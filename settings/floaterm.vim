let g:floaterm_autoclose=2 " always lose float term when job complete

nmap <silent> <leader>tt :FloatermToggle<CR>
imap <silent> <leader>tt <C-O>:FloatermToggle<CR>

nmap <silent><leader>gi :FloatermNew --height=0.9 --width=0.7 --autoclose=2 lazygit<CR>
imap <silent><leader>gi <C-O>:FloatermNew --height=0.9 --width=0.7 --autoclose=2 lazygit<CR>
