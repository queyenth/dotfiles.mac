" vim: set foldmethod=marker foldlevel=0:

if has('vim_starting')
  set all&
endif

let s:plugins=filereadable(expand("~/.vim/autoload/plug.vim", 1))

if !s:plugins
  echo "Installing vim-plug.."
  echo ""
  silent call mkdir(expand("~/.vim/autoload", 1), 'p')
  exe '!curl -fLo '.expand("~/.vim/autoload/plug.vim", 1).' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
  call plug#begin('~/.vim/bundle')

  " Edit
  " Surround vim objects with a pair of indetical chars
  Plug 'tpope/vim-surround'
  " Extend repetitions by the 'dot' key
  Plug 'tpope/vim-repeat'
  " Toggle comments (very useful plugin)
  Plug 'tpope/vim-commentary'
  " Reveals all the character info
  Plug 'tpope/vim-characterize'
  " Wisely add end in Ruby, endfunction in Vim
  Plug 'tpope/vim-endwise'
  " Marks admin
  Plug 'kshenoy/vim-signature'

  " Workflow
  Plug 'szw/vim-ctrlspace'
  Plug 'rizzatti/dash.vim'
  Plug 'airblade/vim-rooter'
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

  " Tmux
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux'
  " Plug 'edkolev/tmuxline.vim'

  " Git
  Plug 'tpope/vim-fugitive'
  " Syntax checking
  Plug 'scrooloose/syntastic'

  " Appearance
  Plug 'bling/vim-airline'
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'mhartington/oceanic-next'
  Plug 'queyenth/oxeded.vim'

  " Langs
  " HTML/CSS/SCSS
  Plug 'othree/html5.vim', { 'for': ['html', 'xhtml', 'css'] }
  Plug 'mattn/emmet-vim', { 'for': ['html', 'xhtml', 'scss', 'xml', 'xls', 'markdown'] }
  Plug 'ap/vim-css-color', { 'for': ['html', 'xhtml', 'scss', 'xml'] }
  Plug 'cakebaker/scss-syntax.vim'
  " PHP
  Plug 'stephpy/vim-php-cs-fixer', { 'for': ['php', 'phtml'] }
  Plug 'joonty/vdebug'
  call plug#end()
endif

" No to the total compatibility with the ancient vim
set nocompatible
set nolist
set virtualedit=block
set nojoinspaces
set nowrap
set shortmess=aIT
set hidden

set autoindent
set smartindent

set noerrorbells
set visualbell
set t_vb=
set tm=500
set mouse=a
set mousemodel=popup

set laststatus=2
set splitright
set splitbelow
set autochdir

" No backups, 2014, you know
set nobackup
set nowb
set noswapfile

set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.sw?,*.luac,*.jar,*.stats

" For additional shortcuts
let mapleader = ","
let maplocalleader = ","

set iminsert=0
set imsearch=0

set completeopt=menuone,menu,longest,preview
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

" Show some data about selected lines,chars
set showcmd

set number
set cursorline
set scrolljump=5
set scrolloff=5

" Set utf-8 encoding
set encoding=utf-8
set termencoding=utf-8
scriptencoding utf-8

" Default filetype - unix
set ffs=unix,dos,mac
set mousehide
set ch=1

" Better screen redraw
set ttyfast
" Set terminal title to the current file
set title
" Update a open file edited outside of Vim
set autoread
" Toggle between modes almost instantly
set ttimeoutlen=0

set history=1000
set undofile
set undodir=~/.vim/tmp/undo/
set undolevels=1000
set undoreload=1000

" Lazy redraw than preprocessing macros, useful for performance
set lazyredraw

" No highlight search results (looks ugly)
set nohlsearch
set incsearch
set ignorecase smartcase

" To make backspace works, like it should works
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Expand tab into spaces, and set it to 4 spaces
set expandtab smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

set formatoptions+=cr
set guioptions=i

set magic
set showmatch
set mat=2

" To return on current line after closing vim
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
set viminfo^=%

autocmd GUIEnter * set vb t_vb= " for your GUI
autocmd VimEnter * set vb t_vb=

au VimResized * exe "normal! \<c-w>="

filetype plugin indent on

" Enabling syntax highlithing
syntax enable
set background=dark
set t_Co=256

colorscheme oxeded
set guifont=Hack:h11
if has("gui_running")
  set guicursor+=a:block-blinkon0
  colorscheme OceanicNext
end


" Useful maping
" map <C-j> <C-W>j
" map <C-h> <C-W>h
" map <C-k> <C-W>k
" map <C-l> <C-W>l

map <A-j> gT
map <A-k> gt

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Split windows
nnoremap <Leader>v <C-w>v
nnoremap <Leader>h <C-w>s

" Cut/Paster to/from the clipboard
map <Leader>y "*y
map <Leader>p "*p
map <Leader>P :set invpaste<CR>

command! ToggleQuickfix call <SID>QuickfixToggle()
nnoremap <silent> <Leader>q :ToggleQuickfix<CR>

" PLUGINS SETUP
" =======================================
" Limelight
let g:limelight_conceal_ctermfg='DarkGray'

" Airline settings
set noshowmode
let g:airline_exclude_preview = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'oxeded'

" Vimux Maps
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

" CtrlSpace settings
let g:ctrlspace_use_tabline = 1

" Commentary
nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary

" Syntastic
nmap <silent><Leader>N :SyntasticCheck<CR>:Errors<CR>
let g:syntastic_python_pyline_exe="pylint2"
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['python']}
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '⚡'
let g:syntastic_style_warning_symbol = '⚡'

" PHP-CS-FIXER
let g:php_cs_fixer_level = 'symfony'
let g:php_cs_fixer_config = 'default'
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_enable_default_mapping = 1
let g:php_cs_fixer_dry_run = 0
let g:php_cs_fixer_verbose = 0

" Vdebug for docker
let g:vdebug_options = {
\    "server" : "192.168.99.100",
\   "break_on_open" : "0",
\}

let g:vdebug_keymap = {
\   "run" : "<Leader>/",
\   "run_to_cursor" : "<Down>",
\   "step_over" : "<Up>",
\   "step_into" : "<Left>",
\   "step_out" : "<Right>",
\   "close" : "g",
\   "detach" : "x",
\   "set_breakpoint" : "<Leader>p",
\   "eval_visual" : "<Leader>e",
\}

" FZF
map <C-p> :Files<CR>

" }} END PLUGIN SETUP
"
" {{ FILETYPES

" PYTHON
au FileType python setlocal foldlevel=1000

" ===============================================
" Helper functions
function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! MakeDirIfNoExists(path)
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path), "p")
  endif
endfunction
