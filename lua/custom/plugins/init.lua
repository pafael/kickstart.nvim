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
			vim.g.copilot_filetypes = {
				['*'] = false,
				['lua'] = true,
				['python'] = true,
				['javascript'] = true,
				['typescript'] = true,
				['typescriptreact'] = true,
				['javascriptreact'] = true,
				['html'] = true,
				['css'] = true,
				['scss'] = true,
				['json'] = true,
				['markdown'] = true,
				['sh'] = true,
				['vim'] = true,
				['c'] = true,
				['cpp'] = true,
				['rust'] = true,
				['go'] = true,
				['java'] = true,
				['php'] = true,
				['blade'] = true,
				['ruby'] = true,
				['haskell'] = true,
				['sql'] = true,
				['dockerfile'] = true,
				['make'] = true,
				['cmake'] = true,
				['xml'] = true,
				['toml'] = true,
				['ini'] = true,
				['svelte'] = true,
			}
		end,
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = "main",
		dependencies = {
		  { "github/copilot.vim" },
		  { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			model = "claude-3.7-sonnet",
		},
		config = function()
			local cc = require("CopilotChat")
			cc.setup({})
			vim.keymap.set('n', '<leader>c', cc.open, { noremap = false })
			vim.api.nvim_create_autocmd('BufEnter', {
				pattern = 'copilot-*',
				callback = function()
					vim.g.copilot_enabled = false
				end
			})
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
	{ 'ggandor/leap.nvim',
		config = function()
			vim.keymap.set({'n'}, '<RIGHT>', '<Plug>(leap-forward)')
			vim.keymap.set({'n'}, '<LEFT>', '<Plug>(leap-backward)')
			vim.keymap.set({'n'}, 'gh', '<Plug>(leap-backward)')
		end,
	},
	{
	  "yetone/avante.nvim",
	  event = "VeryLazy",
	  version = false, -- Never set this value to "*"! Never!
	  opts = {
		-- add any opts here
		-- for example
		provider = "ollama",
		providers = {
			ollama = {
			  endpoint = "http://localhost:11434", -- your ollama server endpoint
			  model = "devstral:24b", -- your desired model (or use llama3.2-70b, etc.)
			  extra_request_body = {
				  temperature = 0,
				  max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				  --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			  },
			},
			openai = {
			  endpoint = "https://api.openai.com/v1",
			  model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
			  timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			  extra_request_body = {
				  temperature = 0,
				  max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				  --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			  },
			  disable_tools = false,
			},
			claude = {
			  endpoint = "https://api.anthropic.com/v1",
			  model = "claude-sonnet-4-20250514", -- your desired model
			  timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			  disable_tools = true,
			  extra_request_body = {
				  max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				  stop_sequences = { "\n\n" }, -- Stop sequences for Claude
			  },
			},
		},
	  },
	  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	  build = "make",
	  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	  dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
		  -- Make sure to set this up properly if you have lazy=true
		  'MeanderingProgrammer/render-markdown.nvim',
		  opts = {
			file_types = { "markdown", "Avante" },
		  },
		  ft = { "markdown", "Avante" },
		},
	  },
	},
	{
	  "inzoiniac/renpy-syntax.nvim",
	  config = function()
		require("renpy-syntax").setup()
	  end,
	}
}
