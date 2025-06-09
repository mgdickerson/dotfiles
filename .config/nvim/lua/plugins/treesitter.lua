return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"RRethy/nvim-treesitter-endwise",
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"comment",
				"c",
				"cpp",
				"dockerfile",
				"html",
				"java",
				"javascript",
				"json",
				"llvm",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			highlight = {
				enable = true,
				disable = function(lang, bufnr)
					if lang == "c" or lang == "cpp" then
						if vim.api.nvim_buf_line_count(bufnr) > 50000 then
							local filepath = vim.fn.expand("%:p")
							vim.api.nvim_echo({
								{ "Treesitter disabled for large files: " .. filepath, "WarningMsg" },
							}, false, {})
							return true
						end
					end
					return false
				end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			endwise = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
  },

  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
}
