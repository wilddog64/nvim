vim.opt.cpo ='$'
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.shada = "'50,<1000,s100,n~/.local/share/nvim/shada/main.shada"
vim.opt.inccommand = "nosplit"
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")
vim.opt.backup = true
vim.opt.backupcopy = "auto"
vim.opt.backupdir = vim.fn.expand("~/.local/share/nvim/backup")
vim.opt.hidden = true
vim.g.mapleader = ";"
vim.g["python3_host_prog"] = "/usr/bin/python3"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.history = 5000    -- command line history
vim.opt.hlsearch = false  -- no highlight search result
vim.opt.incsearch = true  -- do incremental search
vim.opt.number = true     -- turn on numbering
vim.opt.ruler = true      -- turn on ruler
vim.opt.showcmd = true    -- show command
vim.opt.showmatch = true  -- show match of {}, [], <>, ...
vim.g.colorscheme = "solarized8_dark_low"
vim.opt.background = "dark"
vim.opt.diffopt = { "vertical", "iwhite" }
vim.opt.cmdheight = 2
vim.opt.wildmenu = true
vim.opt.conceallevel = 0
vim.opt.laststatus = 2

-- what we want to store in a session file
vim.opt.ssop = {
  "buffers",
  "curdir",
  "folds",
  "resize",
  "winpos",
  "winsize"
}

vim.cmd([[ 
  set statusline=%<%F\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %p
  set wildmode=longest:full,full
  set shm+=film
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
]])
