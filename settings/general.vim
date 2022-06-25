set cpo+=$            " enable cursor line set cpo+=$                  " show $ at the end of line when change it
set cursorline

" enable undofile and setup where to store an undo file
set undofile
" set mouse-=a                " disable mouse interaction
if has("nvim") " for nvim set shada option; otherwise use viminfo
    set shada='50,<1000,s100,n~/.local/share/nvim/shada/main.shada
    set inccommand=nosplit
    let &undodir = expand("~/.local/share/nvim/undo")
    let &backupdir=expand("~/.local/share/nvim/backup")
else
    set viminfo='50,<1000,s100,:0,n~/.local/share/vim/viminfo
    set dir=~/.local/share/vim/swap/ " swap file store at /tmp
    system('mkdir -p ~/.local/share/vim/{undo,backup,swap}')
    let &undodir = expand("~/.local/share/vim/undo")
    let &backupdir=expand("~/.local/share/vim/backup")
end

" make make tabstop, soft tabstop, and shiftwidth all 4
set ts=2
set sts=2
set sw=2

set expandtab
retab

" configure how vim backup files
set backup
set writebackup
set backupcopy=auto
set hidden


" let nvim know python2 and python3 interpreters
" let g:python3_host_prog = expand("~/.pyenv/versions/3.9.0/bin/python")
let g:python3_host_prog = "/usr/bin/python3"

" set leader to be ;
let mapleader=";"

" if no filetype specified, set ft=markdown (alternative would be text)
" autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif

" backsapce over autoindent, line breaks and start of line
set backspace=indent,eol,start
set history=1000      " command line history
set hlsearch        " highlight search result
set incsearch         " do incremental search
set nu                " turn on numbering
set ruler             " turn on ruler
set showcmd           " show command
set showmatch         " show match of {}, [], <>, ...

" set colorscheme
color DimSlate " set color scheme to DimSlate
set bg=dark  " set background to dark

" when diff mode is activated, split buffers vertically and ignore white spaces
set diffopt+=vertical
set diffopt+=iwhite

set cmdheight=2 " make command line two lines height

" for advance completion
set wildmenu
set wildmode=longest:full,full
set path+=**
set completeopt-=preview

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

" diff color settings
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" where to look for a private UltiSnips
let g:UltiSnipsSnippetsDir = expand("~/src/gitrepo/personal/ultisnips")

" these settings will make split windows on the right or bottom

" disable folding
let g:vim_markdown_folding_disabled = 1

" enable spelling check
" set spell spelllang=en_us

let g:ruby_host_prog = '/usr/bin/ruby'
" let g:neocomplete#enable_at_startup = 1

let g:xml_use_xhtml = 1

let g:ale_completeion_enabled = 1

" allow vim to use fzf
set rtp+=/home/linuxbrew/.linuxbrew/bin/fzf

" netrw configuration
let g:netrw_banner = 0 " turn off banner

let g:BASH_InsertFileHeader = 'No'

set laststatus=2
set statusline=%<%F\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %p

" enable relative number
" set relativenumber

" enable code fencing for these language
let g:markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'typescript', 'ts=typescript', 'php', 'html', 'css']

" enable terraform auto format
let g:terraform_fmt_on_save=1
let g:terraform_align=1

if !empty($DISPLAY) && has("unix")
  set clipboard+=unnamedplus
endif
