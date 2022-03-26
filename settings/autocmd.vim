augroup ansiblels
  au!
  au BufRead *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | set ft=yaml.ansible | endif
  au BufEnter *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | endif
augroup END

function! Get_lua_config_dir()
  let b:word = expand("<cWORD>")
  if stridx(b:word, 'require') == -1
    return expand('<cfile>')
  endif
  let b:first_quote = stridx(b:word, "'") + 1
  let b:second_quote = stridx(b:word, "'", b:first_quote)
  let b:length = (b:second_quote - b:first_quote)
  let b:lua_path = strcharpart(b:word, b:first_quote, b:length)
  let b:lua_path = "./lua/" . substitute(b:lua_path, "\\.", "/", "g") . '.lua'
  return b:lua_path
endfunction

augroup luamap
  au BufEnter *.lua nmap <silent> gf :exe "e " . Get_lua_config_dir()<CR>
augroup END
