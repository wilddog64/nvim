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
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)
"
" " Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
"
" " Advanced customization using Vim function
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
"
" " Global line completion (not just open buffers. ripgrep required.)
" inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
"   \ 'prefix': '^.*$',
"   \ 'source': 'rg -n ^ --color always',
"   \ 'options': '--ansi --delimiter : --nth 3..',
"   \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" Required:
" - width [float range [0 ~ 1]] or [integer range [8 ~ ]]
" - height [float range [0 ~ 1]] or [integer range [4 ~ ]]
"
" Optional:
" - xoffset [float default 0.5 range [0 ~ 1]]
" - yoffset [float default 0.5 range [0 ~ 1]]
" - relative [boolean default v:false]
" - border [string default 'rounded']: Border style
"   - 'rounded' / 'sharp' / 'horizontal' / 'vertical' / 'top' / 'bottom' / 'left' / 'right'

" See `man fzf-tmux` for available options
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

let g:fzf_history_dir = '~/.local/share/fzf-history'

if !has('nvim')
  nmap <leader>ff :Files<cr>
  imap <leader>ff <c-o>:Files<cr>

  nmap <leader>fb :Buffers<cr>
  imap <leader>fb <c-o>:Buffers<cr>

  nmap <leader>fg :Rg<cr>
  imap <leader>fg <c-o>:Rg<cr>

  nmap <leader>fh :History<cr>
  imap <leader>fh <c-o>:History<cr>

  nmap <leader>fm :Marks<cr>
  imap <leader>fm <c-o>:Marks<cr>

  nmap <leader>ft :Tags<cr>
  imap <leader>ft <c-o>:Tags<cr>

  nmap <leader>fc :Commands<cr>
  imap <leader>fc <c-o>:Commands<cr>

  nmap <leader>fgc :BCommits<cr>
  imap <leader>fgc <c-o>:BCommits<cr>

  nmap <leader>fgf :GFiles<cr>
  imap <leader>fgf <c-o>:GFiles<cr>

  nmap <leader>fs :Snippets<cr>
  imap <leader>fs <c-o>:Snippets<cr>

  nmap <leader>fl :Lines<cr>
  imap <leader>fl <c-o>:Lines<cr>

  nmap <leader>fbl :BLines<cr>
  imap <leader>fbl <c-o>:BLines<cr>
endif

function! Lazygit()
  if !exists('$TMUX')
    echom('Lazygit requires tmux')
    return
  endif

  let workdir = getcwd()
  let lazygit_cmd = 'tmux display-popup -xC -yC -h50 -w150 -d ' . workdir . " lazygit"
  call system(lazygit_cmd)
endfunction

nnoremap <silent><leader>gi :call Lazygit()<CR>
imap <silent><leader>gi <c-o>:Lazygit()<CR>
