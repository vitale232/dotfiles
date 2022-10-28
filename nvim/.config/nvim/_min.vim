set clipboard=unnamedplus
set wildignore+=**/node_modules/*,**/target/*,**/bin/*,**/obj/*,.git
set mouse=a
set list listchars=tab:⭾ ,trail:␠,nbsp:⎵,multispace:   │
set completeopt+=menu,menuone,noselect

set spell
set spelllang=en_us
set spelloptions=camel

" to create a new file use :e filename <cr>:w
" This broked Telescope's native `find_file` behavior
" set autochdir

" Fancy searching - Only cases sensitive once you use a caps
set incsearch
set ignorecase
set smartcase

" Primagen's tab settings
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Use a local .vimrc if available
set exrc

" Share status bar across splits
set laststatus=3

set nowrap
set number
set relativenumber
set nohlsearch
set noerrorbells
set hidden
set scrolloff=8
set colorcolumn=80,100
set signcolumn=yes

" Having longer update time (default is 4000 ms = 4s) leads to noticeable delays
" and poor UX
set updatetime=50

" This variable must be enabled for colors to be applied properly
set termguicolors

let mapleader = " "

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'gruvbox-community/gruvbox'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-angular'
call plug#end()

" Workaround to CursorLineNr to be highlighted without highlighting whole line
" https://vi.stackexchange.com/a/24605
set cursorline

let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
" let g:tokyonight_style = "night"
" colorscheme tokyonight
highlight Normal guibg=none ctermbg=none
highlight CursorLine guibg=Gray9 ctermbg=none
" https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
" highlight CursorLineNr term=bold guifg=NavajoWhite3 ctermfg=39

" Execute this file
nnoremap <leader><leader>x :call init#save_and_exec()<CR>

if !exists('*init#save_and_exec')
  function! init#save_and_exec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif

    return
  endfunction
endif

