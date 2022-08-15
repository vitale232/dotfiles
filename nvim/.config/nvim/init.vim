set path+=**
set clipboard=unnamedplus
set wildignore+=**/node_modules/*,**/target/*,**/bin/*,**/obj/*,.git
set mouse=a
set list listchars=tab:⭾ ,trail:␠,nbsp:⎵,multispace:   │
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
set updatetime=50

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

" Markdown Table Formatting
Plug 'dhruvasagar/vim-table-mode'

" Snips
Plug 'petertriho/cmp-git'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
" Plug 'rafamadriz/friendly-snippets'

" thing  Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
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
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

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

" lsp_lines config for showing LSP errors in bufs
" lua require('lsp_lines').setup()
lua vim.diagnostic.config({virtual_text = true, severity_sort = true, float = { source = 'always' }})

lua require('harpoon').setup({menu = { width = vim.api.nvim_win_get_width(0) - 20,}})
lua require('telescope').setup{  defaults = { file_ignore_patterns = { "node_modules" }} }
lua require('telescope').load_extension('fzf')
let mapleader = " "
let g:rustfmt_autosave = 1
let g:user_emmet_mode="a"
let g:coc_suggest_disable = 1

" Workaround to CursorLineNr to be highlighted without highlighting whole line
" https://vi.stackexchange.com/a/24605
set cursorline

" let g:gruvbox_contrast_dark = "hard"
" colorscheme gruvbox
let g:tokyonight_style = "night"
colorscheme tokyonight
highlight Normal guibg=none ctermbg=none
highlight CursorLine guibg=none ctermbg=none
" https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
highlight CursorLineNr term=bold guifg=DeepSkyBlue1 ctermfg=39

nnoremap <leader>u :call HandleURL()<cr>
nnoremap <leader>do <cmd>lua vim.diagnostic.open_float()<cr>
" Find files using Telescope command-line sugar.
nnoremap <leader>tele <cmd>Telescope<cr>
nnoremap <leader>ff <cmd>lua require('utils').project_files()<cr>
nnoremap <C-p> :Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>

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

nnoremap <leader>ts :lua require('extenswap').swap_to('ts')<cr>
nnoremap <leader>html :lua require('extenswap').swap_to('html')<cr>
nnoremap <leader>css :lua require('extenswap').swap_to('css')<cr>
nnoremap <leader>scss :lua require('extenswap').swap_to('scss')<cr>
nnoremap <leader>spec :lua require('extenswap').swap_to('spec.ts')<cr>

" Execute this file
nnoremap <leader><leader>x :call init#save_and_exec()<CR>
" luasnip movements
inoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
inoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" coc code spell check via cSpell
nnoremap <leader>a <Plug>(coc-codeaction-selected)


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


" (https://developers.arcgis.com/javascript/latest/api-reference/)
" What if its https://developers.arcgis.com/javascript/latest/api-reference/
" What about href="https://developers.arcgis.com/javascript/latest/api-reference/"
" And then href='https://developers.arcgis.com/javascript/latest/api-reference/'
fun! HandleURL()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    let url_to_visit = ""
    if s:uri[-1:-1] == ")"
        let url_to_visit = s:uri[0:-2]
    elseif s:uri[-1:-1] == '"'
        let url_to_visit = s:uri[0:-2]
    elseif s:uri[-1:-1] == "'"
        let url_to_visit = s:uri[0:-2]
    else
        let url_to_visit = s:uri
    endif
    if url_to_visit != ""
        echo url_to_visit
        silent exec '!"$BROWSER" '.url_to_visit
    else
        echo "No URI found in this line."
    endif
endfun

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

augroup VITALE232
    " Remove all previous listeners (incase the file is source multiple times),
    " then run the command
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufWritePre *.ts,*.html,*.css,*.js,*.lua Neoformat
    autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
augroup END

augroup COC_IT_OFF
    autocmd!
    autocmd BufEnter * let b:coc_suggest_disable = 1
augroup end
