return {
 	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
  },


  -- NvimTree
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<Leader>e", "<Cmd>NvimTreeFindFileToggle<Cr>", desc = "Toggle NvimTree" },
    },
    opts = {
      sort_by = "case_sensitive",
			diagnostics = {
				enable = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
    },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },

  {
		"akinsho/bufferline.nvim",
		version = "v4.*",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<Leader>h", "<Cmd>BufferLineCyclePrev<Cr>", desc = "Go to Left Buffer" },
			{ "<Leader>l", "<Cmd>BufferLineCycleNext<Cr>", desc = "Go to Right Buffer" },
			{ "<Leader>p", "<Cmd>BufferLinePick<Cr>", desc = "Pick Buffer" },
			{ "<Leader><Left>", "<Cmd>BufferLineMovePrev<Cr>", desc = "Move Buffer to Left" },
			{ "<Leader><Right>", "<Cmd>BufferLineMoveNext<Cr>", desc = "Move Buffer to Right" },
			{
				"<Leader>c",
				function()
					-- Close and visually move left.  This is more intuitive because this
					-- avoids jumping around buffers when closing current buffers depending
					-- on the buffer numbers.
					local cur_buf_num = vim.api.nvim_get_current_buf()
					vim.cmd("BufferLineCyclePrev")
					vim.cmd("bdelete " .. cur_buf_num)
				end,
				desc = "Close Buffer",
			},
		},
		init = function()
			-- Persistent bufferline positions
			vim.o.sessionoptions = vim.o.sessionoptions .. ",globals"
		end,
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				theme = "tokyonight-moon",
			},
			extensions = {
				"lazy",
				"nvim-tree",
				"quickfix",
				"toggleterm",
				"trouble",
			},
		},
	},

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    opts = {
      open_mapping = [[<c-\>]],
      direction = 'float',
      -- float_ops = {
      --   border = 'shadow',
      -- },
      -- Change shell for terminal opened:
      -- shell = vim.o.shell,
    }
  },

  -- Indentation
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "v3.*",
		lazy = true,
		event = "BufReadPost",
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IBLYellow", { fg = "#E5C07B" })
			end)

			require("ibl").setup({
				exclude = {
					filetypes = {
						"nvim-tree",
						"lazy",
					},
				},
				indent = {
					char = "▏",
					smart_indent_cap = false,
				},
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
					highlight = {
						"IBLYellow",
					},
				},
			})
		end,
	},

  -- Highlight the same word
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufReadPost",
		opts = {
			providers = {
				"lsp",
				-- "treesitter", too slow
				"regex",
			},
			filetypes_denylist = {
				"NvimTree",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local highlight = "#354A51" -- material oceanic highlight
			vim.api.nvim_set_hl(0, "IlluminatedWordText", {
				bg = highlight,
			})
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", {
				bg = highlight,
			})
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
				bg = highlight,
			})
		end,
	},
}
