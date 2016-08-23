set cursorline              " enable cursor line
set cpo+=$                  " show $ at the end of line when change it
set dir=~/.vim/swap/        " swap file store at /tmp
set backupdir=~/.vim/backup " backup directory
set undodir=~/.vim/undo     " undo directory

if version > 702
    set undofile    " turn on undofile, so undo information is preserved for the next time."
    let &undodir = expand("~") . "/backup/vimundo"
endif

" let nvim know python2 and python3 interpreters
let g:python_host_prog = expand("~/.pyenv/versions/2.7.12/bin/python")
let g:python3_host_prog = expand("~/.pyenv/versions/3.4.4/bin/python")

" set leader to be ,
let mapleader=","

" if no filetype specified, set ft=markdown (alternative would be text)
autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif

" backsapce over autoindent, line breaks and start of line
set backspace=indent,eol,start
set bg=dark           " set backgroup to dark
set history=5000      " command line history
set nohlsearch        " highlight search result
set incsearch         " do incremental search
set nu                " turn on numbering
set ruler             " turn on ruler
set showcmd           " show command
set showmatch         " show match of {}, [], <>, ...

" increase status line, and display more information for it
set laststatus=2
set statusline=%f\ %h%m%r%{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v]

" when diff mode is activated, split buffers vertically and ignore white spaces
set diffopt+=vertical
set diffopt+=iwhite

set cmdheight=2 " make command line two lines height

" for advance completion
set wildmenu
set wildmode=longest:full,full

" display shot message, f: (3 of 5) instead of (file 3 of 5),
" i [noeol] for [Incomplete last line], m: [+] for modified
set shm+=film

" what do we store for a session when mksession is executed
set ssop+=buffers
set ssop+=curdir
set ssop+=folds
set ssop+=resize
set ssop+=tabpages
set ssop+=winpos
set ssop+=winsize

set listchars=tab:▸\ ,trail:⋅,nbsp:⋅,eol:¬ " specfiy the invisible characters
set printoptions+=number:y

set clipboard=unnamed

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  augroup END
endif

" setup plugin manager
call plug#begin('~/.config/nvim/plugged')

source ~/.config/nvim/settings/functions.vim

" a list of plugins we want to have
Plug 'davidhalter/jedi-vim'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'benmills/vimux'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'sjl/gundo.vim'
Plug 'SirVer/ultisnips'
Plug 'edsono/vim-matchit'
Plug 'fatih/vim-go'
Plug 'dbakker/vim-projectroot'
Plug 'corntrace/bufexplorer'
Plug 'elzr/vim-json'
Plug 'benmills/vimux'
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" at the end, add plugins to the runtime path
call plug#end()

source ~/.config/nvim/settings/functions.vim
source ~/.config/nvim/settings/keymaps.vim
source ~/.config/nvim/settings/taglist.vim
source ~/.config/nvim/settings/gundo.vim
source ~/.config/nvim/settings/syntastics.vim
source ~/.config/nvim/settings/vim-jedi.vim
source ~/.config/nvim/settings/vim-json.vim
source ~/.config/nvim/settings/vimux.vim
source ~/.config/nvim/settings/deoplete.vim
source ~/.config/nvim/settings/easy-align.vim
