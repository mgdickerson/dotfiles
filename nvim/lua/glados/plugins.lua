local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print "Packer protected call failed..."
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Packer Self Manager
  use "wbthomason/packer.nvim"

  -- Buffer Line
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  -- Themes
  use 'EdenEast/nightfox.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Navigation
  use { 'junegunn/fzf', run = function () vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'

  -- Completion plugin
  use "hrsh7th/nvim-cmp"                  -- completion plugin
  use "hrsh7th/cmp-buffer"                -- buffer completions
  use "hrsh7th/cmp-path"                  -- path completions
  use "hrsh7th/cmp-cmdline"               -- cmdline completions
  use "saadparwaiz1/cmp_luasnip"          -- lua snippet completions
  use "hrsh7th/cmp-nvim-lsp"              -- completions for LSP
  use "hrsh7th/cmp-nvim-lua"

  -- Snippets
  use "L3MON4D3/LuaSnip"                  -- snippet engine
  use "rafamadriz/friendly-snippets"      -- bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig"             -- enable LSP
  use "williamboman/nvim-lsp-installer"   -- simple to use language server installer

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

