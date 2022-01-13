local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Keymap name alias
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"
--
-- Terms
-- <S-[letter]> -- (S) Shift
-- <A-[letter]> -- (A) Alt
-- <C-[letter]> -- (C) Ctrl

-- Normal --
-- Lex Shortcut
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Navigate Buffers
keymap("n", "<C-l>", ":bnext<CR>", opts)        -- next buffer
keymap("n", "<C-h>", ":bprevious<CR>", opts)    -- previous buffer
keymap("n", "<C-w>", ":bd<CR>", opts)           -- close current buffer

keymap("n", "<C-u>", ":redo<CR>", opts)         -- redo
keymap("n", "<C-p>", ":Files<CR>", opts)        -- fzf find files
keymap("n", "<C-r>", ":Rg<CR>", opts)           -- ripgrep
