set cursorline              " enable cursor line set cpo+=$                  " show $ at the end of line when change it
set dir=~/.vim/swap/        " swap file store at /tmp
set undodir=~/.vim/undo     " undo directory
set mouse-=a                " disable mouse interaction
if has("nvim")
    set shada='50,<1000,s100,n~/.local/share/nvim/shada/main.shada
end

" make make tabstop, soft tabstop, and shiftwidth all 4
set ts=4
set sts=4
set sw=4

set expandtab
retab

set backup
set writebackup
let &backupdir=expand("~") . "/backup/vimbackup"
set backupcopy=auto

" enable undofile and setup where to store an undo file
set undofile    " turn on undofile, so undo information is preserved for the next time."
let &undodir = expand("~") . "/backup/vimundo"

" let nvim know python2 and python4 interpreters
let g:python_host_prog = expand("~/.pyenv/versions/2.7.13/bin/python")
let g:python3_host_prog = expand("~/.pyenv/versions/3.6.0/bin/python")

" set leader to be ,
let mapleader=","

" if no filetype specified, set ft=markdown (alternative would be text)
" autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif

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

" allow vim to use clipboard for all operations
set clipboard=unnamedplus

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
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'chiel92/vim-autoformat'
Plug 'corntrace/bufexplorer'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jalvesaq/vimcmdline'
Plug 'jiangmiao/auto-pairs'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/vim-easy-align'
Plug 'lepture/vim-jinja'
Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
Plug 'saltstack/salt-vim'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-perl/vim-perl'
Plug 'jsfaint/gen_tags.vim'
Plug 'flazz/vim-colorschemes'

if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
end

" at the end, add plugins to the runtime path
call plug#end()

source ~/.config/nvim/settings/keymaps.vim
source ~/.config/nvim/settings/taglist.vim
source ~/.config/nvim/settings/gundo.vim
source ~/.config/nvim/settings/syntastics.vim
source ~/.config/nvim/settings/vim-jedi.vim
source ~/.config/nvim/settings/vim-json.vim
source ~/.config/nvim/settings/vimux.vim
if has("nvim")
    source ~/.config/nvim/settings/deoplete.vim
end
source ~/.config/nvim/settings/easy-align.vim
source ~/.config/nvim/settings/markdown.vim
source ~/.config/nvim/settings/ansible.vim
source ~/.config/nvim/settings/cbackup.vim
