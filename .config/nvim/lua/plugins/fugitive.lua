return {
  -- Git Integration
  "tpope/vim-fugitive",

	{
		"lewis6991/gitsigns.nvim",
		version = "v1.*",
		lazy = true,
		event = "BufReadPre",
		opts = {
			-- GitLens-like blame line
			current_line_blame = true,
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<Leader>gn", function()
					if vim.wo.diff then
						vim.cmd.normal({ "<Leader>gn", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Go to next Git hunk" })

				map("n", "<Leader>gp", function()
					if vim.wo.diff then
						vim.cmd.normal({ "<Leader>gp", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Go to previous Git hunk" })

				-- Actions
				map("n", "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage Git hunk" })
				map("n", "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset Git hunk" })

				map("v", "<Leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Git hunk" })

				map("v", "<Leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Git hunk" })

				map("n", "<Leader>gS", gitsigns.stage_buffer, { desc = "Stage Git buffer" })
				map("n", "<Leader>gR", gitsigns.reset_buffer, { desc = "Reset Git buffer" })
				map("n", "<Leader>gP", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
				map("n", "<Leader>gi", gitsigns.preview_hunk_inline, { desc = "Preview Git hunk inline" })

				map("n", "<Leader>gb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame Git line" })

				map("n", "<Leader>gd", gitsigns.diffthis, { desc = "Diff Git" })

				map("n", "<Leader>gD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff Git" })

				-- Text object
				map({ "o", "x" }, "<Leader>gh", gitsigns.select_hunk, { desc = "Select Git hunk" })
			end,
		},
	},
}
