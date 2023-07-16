let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
let g:slime_paste_file = '/tmp/slime_paste'
" let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1
let g:slime_preserve_curpos = 0

let g:slime_no_mappings = 1
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeMotionSend
nmap <leader>ss <Plug>SlimeLineSend

