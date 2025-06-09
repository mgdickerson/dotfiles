-- Load Vim Configuration
local config_home = os.getenv("XDG_CONFIG_HOME") or "~/.config"

-- Runtime path settings
vim.cmd("set runtimepath^=" .. config_home .. "/vim runtimepath+=" .. config_home .. "/vim/after")
vim.o.packpath = vim.o.runtimepath
vim.cmd("source " .. config_home .. "/vim/vimrc")

-- Enable fast cache loading
if vim.loader then
  vim.loader.enable()
end

-- Disable netrw at beginning of init.lua for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.signcolumn = "yes"

-- Apply color scheme:
-- vim.cmd[[colorscheme tokyonight]]

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({timeout = 500})
  end,
})

if os.getenv("NVIM_NO_PLUGINS") ~= "1" then
  require("config.lazy")
end

vim.opt.secure = true
