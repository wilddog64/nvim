" The wildmenu is the tab-complete list in command mode, for auto-completing
" commands and file paths. When doing the latter, it will ignore these
" patterns.
set wildignore+=*.pyc,*.pyo,*/__pycache__/* " Python
set wildignore+=*.o,*.ko,*.obj,*.dSYM       " C
set wildignore+=*.swp,~*                    " Temp files
set wildignore+=*.zip,*.tar                 " Archives
set wildignore+=node_modules/*              " Javascript / Node.js

let g:itchy_always_split = 1
let g:itchy_split_direction = 2

" mapping for nvim-tree
nmap <leader>n :NvimTreeToggle<CR>
imap <leader>n <C-O>:NvimTreeToggle<CR>
nmap <leader>f :NvimTreeFindFile<CR>
imap <leader>f <C-O>:NvimTreeFindFile<CR>
