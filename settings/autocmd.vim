augroup ansiblels
  au!
  au BufRead *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | set ft=yaml.ansible | endif
  au BufEnter *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | endif
augroup END

function! Get_lua_config_dir() abort
  " Get the current line and check if it contains 'require'
  let l:line = getline(line("."))
  if match(l:line, 'require') == -1
    " Handle paths starting with ~
    if match(l:line, '~') != -1
      let l:expanded_path = expand(matchstr(l:line, '~.*'))
      if filereadable(l:expanded_path)
        return l:expanded_path
      endif
    endif
    return ""
  endif

  " Determine the type of quote used
  let l:quote = match(l:line, "'") != -1 ? "'" : '"'

  " Extract the Lua module path between quotes
  let l:module_path = matchstr(l:line, l:quote . '\zs.\{-}\ze' . l:quote)
  let l:lua_file_path = './lua/' . substitute(l:module_path, '\.', '/', 'g')

  " Check for the Lua file and init.lua
  if filereadable(l:lua_file_path . '.lua')
    return l:lua_file_path . '.lua'
  elseif filereadable(l:lua_file_path . '/init.lua')
    return l:lua_file_path . '/init.lua'
  endif

  return ""
endfunction

augroup luamap
  au BufEnter *.lua nmap <silent> gf :exe "e " . Get_lua_config_dir()<CR>
augroup END

" this autocommand group setup some formation options for editing buffers
augroup formatoptions
  au!
  au FileType * set fo-=o   " disable continuation of comments when using 'o' or 'O'
  au FileType * set fo+=j   " remove a comment leader when join lines
  au FileType * set fo+=l   " don't break a line after a one-letter word
  au FileType * set fo+=n   " recognize numbered list
augroup END

augroup helpmapping
  au!
  autocmd FileType help nnoremap <buffer> <CR> <C-]>
  autocmd FileType help nnoremap <buffer> <BS> <C-T>
  autocmd FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>
  autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
  autocmd FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
  autocmd FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
augroup END

if has('nvim')
  augroup sessions
    autocmd!
    autocmd FocusLost * wshada
    autocmd FocusGained * rshada
  augroup end
endif

augroup tabconf
    autocmd!

    " 2-space tab languages
    autocmd Filetype
\       yaml,html,css,htmldjango,javascript,javascriptreact,typescript,typescriptreact,markdown,terraform,lua
\       setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

    " 3-space tab languages (why, reStructured text, why?!?)
    autocmd Filetype rst setlocal tabstop=3 shiftwidth=3 softtabstop=3 expandtab
augroup END

" content will be copy to clipboard
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif

" only load vim-lsp for these file types
autocmd FileType python,javascript,yaml call lsp#enable()
