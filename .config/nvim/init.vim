set encoding=utf-8
scriptencoding utf-8

set runtimepath +=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/defx.nvim')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('cohama/lexima.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('hashivim/vim-terraform')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('osyo-manga/vim-over')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('w0rp/ale')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('fatih/vim-go')
  call dein#add('deoplete-plugins/deoplete-go')
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax on
colorscheme hybrid

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
set clipboard=unnamed

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

nnoremap [denite] <Nop>
nmap <leader>d [denite]

nnoremap <silent> [denite]f :Denite file/rec<CR>
nnoremap <silent> [denite]g :Denite grep<CR>
nnoremap <silent> [denite]b :Denite buffer<CR>
nnoremap <silent><C-n> :Defx<CR>
nnoremap <silent><C-s> :OverCommandLine<CR>

" ctags
let g:pid = getpid()
let g:tags_file_path = "/tmp/" . "tags" . g:pid

function! s:ctags_generate() abort
  exe 'silent! !ctags -R -f '.g:tags_file_path.' $(pwd) &'
  exe 'set tags='.g:tags_file_path
endfunction
command! -nargs=0 CtagsGenerate call s:ctags_generate()

function! s:ctags_remove() abort
  exe 'silent! !rm -f '.g:tags_file_path
endfunction
command! -nargs=0 CtagsRemove call s:ctags_remove()

autocmd VimEnter * silent! :CtagsGenerate
autocmd BufWrite * silent! :CtagsGenerate
autocmd VimLeave * silent! :CtagsRemove

" Shougo/denite.nvim
if executable('rg')
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git', '--hidden'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
endif

call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" Shougo/defx.nvim
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ? defx#do_action('open') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> s
  \ defx#do_action('multi', ['drop', 'split'])
  nnoremap <silent><buffer><expr> v
  \ defx#do_action('multi', ['drop', 'vsplit'])
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('toggle_ignored_files')
endfunction

autocmd VimEnter * call defx#custom#option('_', {
     \   'columns': 'indent:icons:filename:type',
     \   'direction': 'topleft',
     \   'split': 'vertical',
     \   'winwidth': 40,
     \   'toggle': 1,
     \   'show_ignored_files': 1,
     \ })

" hashivim/vim-terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" bronson/vim-trailing-whitespace
autocmd BufWrite * silent! :FixWhitespace

" w0rp/ale
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
    \   'c' : ['clang-format'],
    \   'cpp' : ['clang-format']
    \}

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1

" fatih/vim-go
let g:go_fmt_command = "goimports"

" startup
autocmd VimEnter * Defx
autocmd VimEnter * wincmd l

augroup vagrant
  autocmd!
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
