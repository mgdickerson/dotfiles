return {
  -- Telescope
  {
		"nvim-telescope/telescope.nvim",
		version = "0.1.*",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "1.*",
			},
			"tom-anders/telescope-vim-bookmarks.nvim",
		},
		keys = {
			{ "<Leader>fg", "<Cmd>Telescope live_grep_args<Cr>", desc = "Telescope Grep" },
			{ "<Leader>fr", "<Cmd>Telescope resume<Cr>", desc = "Telescope Resume" },
			{ "<Leader>fb", "<Cmd>Telescope buffers<Cr>", desc = "Telescope Buffers" },
			{ "<Leader>fB", "<Cmd>Telescope vim_bookmarks all<Cr>", desc = "Telescope Bookmarks" },
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git" },
				mappings = {
					i = {
						["<C-p>"] = "cycle_history_prev",
						["<C-n>"] = "cycle_history_next",
					},
				},
			},
			pickers = {
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				live_grep_args = {
					auto_quoting = true,
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("vim_bookmarks")
		end,
	},

  {
		"prochri/telescope-all-recent.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"kkharji/sqlite.lua",
		},
		keys = {
			{
				"<Leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope Files",
			},
		},
		config = true,
	},
}
