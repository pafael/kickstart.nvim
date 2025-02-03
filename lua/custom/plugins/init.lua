-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		'github/copilot.vim',
		config = function()
			vim.api.nvim_set_keymap('n', '<leader>cp', ':Copilot<CR>', { noremap = true, silent = true })
			vim.keymap.set('i', '<C-O>', 'copilot#Accept("\\<CR>")', { expr = true, noremap = true, replace_keycodes = false})
			vim.keymap.set('i', '<C-S>', '<Plug>(copilot-suggest)', { noremap = false })
			vim.keymap.set('i', '<C-N>', '<Plug>(copilot-next)', { noremap = false })
			vim.keymap.set('i', '<C-P>', '<Plug>(copilot-prev)', { noremap = false })
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = "main",
		dependencies = {
		  { "github/copilot.vim" },
		  { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		config = function()
			local cc = require("CopilotChat")
			cc.setup({})
			vim.keymap.set('n', '<leader>c', cc.open, { noremap = false })
		end,
	},
	{ 'jonarrien/telescope-cmdline.nvim',
		keys = {
			{'Q', '<cmd>Telescope cmdline<cr>', desc = "Cmdline"},
		},
	},
	{ 'EmranMR/tree-sitter-blade',
		config = function()
			local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
			parser_config.blade = {
			  install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = { "src/parser.c" },
				branch = "main",
			  },
			  filetype = "blade"
			}
		end
	},
}
