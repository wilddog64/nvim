let g:floaterm_autoclose=2 " always lose float term when job complete

nmap <silent> <leader>tn :FloatermNew<CR>
imap <silent> <leader>tn <C-O>:FloatermNew<CR>

nmap <silent><leader>gi :FloatermNew --height=0.9 --width=0.7 --autoclose=2 lazygit<CR>
imap <silent><leader>gi <C-O>:FloatermNew --height=0.9 --width=0.7 --autoclose=2 lazygit<CR>
