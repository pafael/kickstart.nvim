local autosession_set = false

vim.opt.foldenable = false

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  desc = 'Set shada to save global marks',
  group = vim.api.nvim_create_augroup('kickstart-shada', { clear = true }),
  callback = function()

    if(autosession_set) then
      return
    end
    autosession_set = true

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
    end, { ['repeat'] = -1 })
    vim.fn.timer_start(30000, function()
      vim.cmd('mksession! .vim_session')
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
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<cmd>cprevious<CR>', { noremap = true, silent = true })

vim.api.nvim_create_augroup('BladeFiletypeRelated', { clear = true })
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.blade.php',
  command = 'setlocal filetype=blade',
  group = 'BladeFiletypeRelated',
})
