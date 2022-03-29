augroup ansiblels
  au!
  au BufRead *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | set ft=yaml.ansible | endif
  au BufEnter *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | endif
augroup END

function! Get_lua_config_dir()
  let b:word = getline(line("."))
  if stridx(b:word, 'require') == -1
    if stridx(b:word, '~')
      let b:word = strpart(b:word, stridx(b:word, '~'), strlen(b:word))
      if filereadable(expand(b:word))
        return expand('<cfile>')
      endif
    endif
  endif

  let b:looking_for = "'"
  if stridx(b:word, b:looking_for) == -1
    let b:looking_for = '"'
  endif

  let b:first_quote = stridx(b:word, b:looking_for) + 1
  let b:second_quote = stridx(b:word, b:looking_for, b:first_quote)
  let b:length = (b:second_quote - b:first_quote)
  let b:lua_path = strcharpart(b:word, b:first_quote, b:length)
  let b:lua_file_path = "./lua/" . substitute(b:lua_path, "\\.", "/", "g")
  let b:lua_file = b:lua_file_path . '.lua'
  if filereadable(b:lua_file)
    return b:lua_file
  else
    let b:lua_init_file = b:lua_file_path . '/init.lua'
    if filereadable(b:lua_init_file)
      return b:lua_init_file
    endif
  endif
  let b:cur_dir = expand("%h")
  if stridx(b:lua_path, ".")
    let b:full_path = b:cur_dir . '/' . b:lua_path
    if !empty(glob(b:full_path))
      return b:full_path
    endif
  endif
endfunction

augroup luamap
  au BufEnter *.lua nmap <silent> gf :exe "e " . Get_lua_config_dir()<CR>
augroup END
