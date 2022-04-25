let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
  \ { 'fg':    ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" allow vi/vim to use fzf
set rtp+=/usr/local/opt/fzf

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

if !has('nvim')
  nmap <leader>ff :Files<cr>
  imap <leader>ff <c-o>:Files<cr>

  nmap <leader>fb :Buffers<cr>
  imap <leader>fb <c-o>:Buffers<cr>

  nmap <leader>fs :Rg<cr>
  imap <leader>fs <c-o>:Rg<cr>

  nmap <leader>fh :History<cr>
  imap <leader>fh <c-o>:History<cr>

  nmap <leader>fm :Marks<cr>
  imap <leader>fm <c-o>:Marks<cr>

  nmap <leader>ft :Tags<cr>
  imap <leader>ft <c-o>:Tags<cr>

  nmap <leader>fc :Commands<cr>
  imap <leader>fc <c-o>:Commands<cr>

  nmap <leader>fg :BCommits<cr>
  imap <leader>fg <c-o>:BCommits<cr>
endif

