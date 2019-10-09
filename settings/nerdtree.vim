" augroup nerdtree
"     autocmd!
"     " open NerdTree if the pass in argument is a directory
"     autocmd StdinReadPre * let s:std_in = 1
"     autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'cd ' argv()[0] | endif
" augroup end

map <C-t> :NERDTreeToggle<CR>
