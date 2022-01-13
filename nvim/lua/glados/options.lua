-- For more options, :help options
-- To quit help, :q

local options = {
  -- Basic Options
  mouse = "a",                       -- allow mouse to be used in neovim
  clipboard = "unnamedplus",         -- allow neovim to access system clipboard
  history = 1000,                    -- set history of commands length
  mousehide = true,                  -- hide mouse pointer while typing
  spell = true,                      -- turns on spell check
  virtualedit = "onemore",           -- allows cursor to go one past end
  hidden = true,                     -- when off a buffer is unloaded when not current

  -- UI Options
  backspace = [[indent,eol,start]],  -- backspace functionality over indent, eol, and start
  linespace = 0,                     -- number of pixel lines inserted between characters
  number = true,                     -- show numbers
  showmatch = true,                  -- shows matching bracket
  incsearch = true,                  -- turns on incremental search
  hlsearch = true,                   -- highlight all matching search patterns
  ignorecase = true,                 -- turn off case sensitivity
  wildmenu = true,                   -- turns on "enhanced" command-line completion
  cursorline = false,                -- puts cursor under current line
  list = true,                       -- shows trailing spaces and tabs
  scrolloff = 3,                     -- number of spaces below scroll

  -- Formatting Options
  wrap = false,                      -- turns off wrapping lines
  autoindent = true,                 -- smart indentation
  shiftwidth = 2,                    -- controls tab size
  expandtab = true,                  -- turns tabs into spaces
  tabstop = 2,                       -- controls backspacing tabs
  softtabstop = 2,                   -- controls tab size

  -- Color Options
  termguicolors = true,            -- fancy colors
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set wildmode=list:longest,full"
vim.cmd "set whichwrap+=b,s,h,l,<,>,[,]"

-- Buffer "tabs" at the top
require("bufferline").setup{}

-- Theme Setup
require('nightfox').load('nordfox')
