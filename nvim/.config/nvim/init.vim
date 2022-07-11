set path+=**
set clipboard=unnamedplus
set wildignore+=**/node_modules/*,**/target/*,**/bin/*,**/obj/*,.git
set mouse=a
set list listchars=tab:␉·,trail:␠,nbsp:⎵,multispace:   │
set completeopt+=menu,menuone,noselect

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

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays
" and poor UX
set updatetime=500

" This variable must be enabled for colors to be applied properly
set termguicolors

call plug#begin()
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'junegunn/fzf'

" Doc Generator (JsDoc)
Plug 'kkoomen/vim-doge'

" Snips
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" thing  Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" Fuzzy finder
" Optional
" Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Typescript and web
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ShooTeX/nvim-treesitter-angular'
Plug 'MunifTanjim/eslint.nvim'
Plug 'mattn/emmet-vim'

" Formatting documents
Plug 'sbdchd/neoformat'
" Comments
Plug 'scrooloose/nerdcommenter'

" File tree via nvim-tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Status bar pimpage
Plug 'vim-airline/vim-airline'

" Python
Plug 'tree-sitter/tree-sitter-python'

" Harpooning
Plug 'ThePrimeagen/harpoon'

call plug#end()

lua require('harpoon').setup({menu = { width = vim.api.nvim_win_get_width(0) - 20,}})
lua require('rust-tools').setup({})
lua require('telescope').setup{  defaults = { file_ignore_patterns = { "node_modules" }} }
lua require('av-nvim-cmp-conf')
lua require('av-lsp-actions')
lua require('av-ts-lsp-conf')
lua require('av-lua-lsp-conf')
lua require('av-nvim-tree')
lua require('av-treesitter-conf')
let mapleader = " "
let g:rustfmt_autosave = 1
let g:user_emmet_mode="a"
let g:coc_suggest_disable = 1

 " let g:gruvbox_contrast_dark = "hard"
 " colorscheme gruvbox
let g:tokyonight_style = "night"
colorscheme tokyonight
highlight Normal guibg=none ctermbg=none

nnoremap <leader>u :call HandleURL()<cr>
nnoremap <leader><C-e> <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> :Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>FF :Neoformat<cr>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

" Harpooning
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hh :lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>hn :lua require("harpoon.ui").nav_next()<cr>
nnoremap <leader>hN :lua require("harpoon.ui").nav_prev()<cr>

nnoremap <C-h> :lua require("harpoon.ui").nav_file(1)<cr>
nnoremap <C-t> :lua require("harpoon.ui").nav_file(2)<cr>
nnoremap <C-n> :lua require("harpoon.ui").nav_file(3)<cr>
nnoremap <C-s> :lua require("harpoon.ui").nav_file(4)<cr>

nnoremap <leader>ts :lua require('extenswap').switch_to('ts')<cr>
nnoremap <leader>html :lua require('extenswap').switch_to('html')<cr>
nnoremap <leader>css :lua require('extenswap').switch_to('css')<cr>
nnoremap <leader>scss :lua require('extenswap').switch_to('scss')<cr>
nnoremap <leader>spec :lua require('extenswap').switch_to('spec.ts')<cr>

" coc code spell check via cSpell
nnoremap <leader>a <Plug>(coc-codeaction-selected)

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

" Automatic file formatting

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

" Automatic file formatting

" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue

" Automatic file formatting
let g:neoformat_try_node_exe = 1

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! IgnoreCamelCaseSpell()
  syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
endfun

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction

augroup VITALE232
    " Remove all previous listeners (incase the file is source multiple times),
    " then run the command
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufWritePre *.ts,*.html,*.css,*.js Neoformat
    autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
augroup END

augroup COC_IT_OFF
    autocmd!
    autocmd BufEnter * let b:coc_suggest_disable = 1
augroup end
