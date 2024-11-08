local autosession_set = false

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  desc = 'Set shada to save global marks',
  group = vim.api.nvim_create_augroup('kickstart-shada', { clear = true }),
  callback = function()

    if(autosession_set) then
      return
    end
    autosession_set = true
    local function echo_with_clear(message)
      print(message)
      vim.fn.timer_start(1000, function()
        vim.cmd('redraw')
      end)
    end

    if vim.fn.filereadable('.vim_shada') == 1 then
      vim.cmd('rshada! .vim_shada')
    end
    if vim.fn.filereadable('.vim_session') == 1 then
      vim.cmd('source .vim_session')
      vim.fn.timer_start(10, function()
        vim.cmd('edit')
      end)
    end
    vim.fn.timer_start(45000, function() 
      vim.cmd('wshada! .vim_shada') 
      echo_with_clear("Saved shada") 
    end, { ['repeat'] = -1 })
    vim.fn.timer_start(30000, function() 
      vim.cmd('mksession! .vim_session') 
      echo_with_clear("Saved session")
    end, { ['repeat'] = -1 })
  end,
})

local function jump_to_previous_buffer()
	local currBuff = vim.fn.bufnr()
	local lastJump = -1
	while vim.fn.bufnr() == currBuff  and lastJump ~= vim.fn.getjumplist()[2] do
		vim.cmd('execute "normal 1\\<c-o>"')
	end
	vim.cmd('redraw')
end

local function jump_to_next_buffer()
	local currBuff = vim.fn.bufnr()
	local lastJump = -1
	while vim.fn.bufnr() == currBuff and lastJump ~= vim.fn.getjumplist()[2] do
		vim.cmd('execute "normal 1\\<c-i>"')
		lastJump = vim.fn.getjumplist()[2]
	end
	vim.cmd('redraw')
end

vim.keymap.set('n', '<leader>o', jump_to_previous_buffer, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>i', jump_to_next_buffer, { noremap = true, silent = true })
