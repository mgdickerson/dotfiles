"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=<path_to_dein.vim>

" Required:
call dein#begin(<path_to_share_dein_folder>)

" Let dein manage dein
" Required:
call dein#add(<path_to_dein_repo_Shougo_dein.vim>)
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
call dein#add('joshdick/onedark.vim')     " OneDark Theme
call dein#add('sheerun/vim-polyglot')     " Syntax Highlighting
call dein#add('scrooloose/nerdtree')      " NerdTree Folder Explorer
call dein#add('scrooloose/nerdcommenter') " NerdCommenter for comments
call dein#add('ryanoasis/vim-devicons')   " Additional NerdTree Icons
call dein#add('itchyny/lightline.vim')    " Bottom Bar Highlight
call dein#add('tpope/vim-fugitive')       " Git Features in NVIM

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" Install uninstalled plugins on startup
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Lightline config
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" Basic Settings :
set mouse=a
set mousehide
set virtualedit=onemore
set history=1000
set hidden

" UI :
set linespace=0
set number
set showmatch
set incsearch
set hlsearch
set ignorecase
set wildmenu
set wildmode=list:longest,full
set noshowmode
set cursorline

" Formatting :
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent

" OneDark Theme Settings :

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark
syntax on
colorscheme onedark
