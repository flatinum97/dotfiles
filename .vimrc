set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bronson/vim-trailing-whitespace'
Plug 'osyo-manga/vim-over'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
call plug#end()

filetype plugin indent on
syntax on
set background=dark
colorscheme hybrid_material

set hidden
set number
set showcmd
set noshowmode
set title
set nobackup
set noswapfile
set autoread
set showmatch
set cursorline
set wildmenu
set laststatus=2
set ruler
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start

if has('unix')
  set clipboard^=unnamedplus
else
  set clipboard^=unnamed
endif

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

nnoremap <space> <nop>
xnoremap <space> <nop>
let mapleader = "\<space>"

inoremap <silent>jk <ESC>

nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l
nnoremap <silent> <C-j> <C-W>j
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <ESC><ESC> :noh<CR>
nnoremap j gj
nnoremap k gk

nnoremap <silent>H :bprevious<CR>
nnoremap <silent>L :bnext<CR>
nnoremap <silent><C-w> :bd<CR>

nnoremap [fzf] <Nop>
nmap <leader>d [fzf]

nnoremap <silent> [fzf]f :GFiles<CR>
nnoremap <silent> [fzf]g :Rg<CR>
nnoremap <silent> [fzf]b :Buffers<CR>
nnoremap <silent><C-s> :OverCommandLine<CR>

" bronson/vim-trailing-whitespace
autocmd BufWrite * silent! :FixWhitespace

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "hybrid"

" prabirshrestha/vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
