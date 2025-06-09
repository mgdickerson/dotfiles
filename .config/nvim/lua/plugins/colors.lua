return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
		config = function()
			vim.g.material_style = "tokyonight-moon"
			vim.cmd.colorscheme("tokyonight-moon")
		end,
  }
}
