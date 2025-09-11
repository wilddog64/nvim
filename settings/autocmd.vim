augroup ansiblels
  au!
  au BufRead *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | set ft=yaml.ansible | endif
  au BufEnter *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | lcd %:h:h | endif
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

" only load vim-lsp for these file types, only if we use vim
if !has('nvim')
   autocmd FileType python,javascript,yaml call s:conditional_lsp_enable()

   function! s:conditional_lsp_enable() abort
     " Get the current file path
     let l:fname = expand('%:p')
     if l:fname ==# ''
       return
     endif

     " Determine the root directory using vim.fs.find
     let l:startpath = luaeval('vim.fs.dirname(vim.fn.expand("%:p")) or vim.fn.getcwd()')
     let l:git_dir = luaeval('vim.fs.find(".git", { path = "' . l:startpath . '", upward = true })[1]')

     " Only enable LSP if a valid project root is found
     if !empty(l:git_dir)
       call lsp#enable()
     endif
   endfunction
endif

function! <SID>AutoProjectRootCD()
   try
      if &ft != 'help'
         let l:realfile = resolve(expand('%:p'))
         if filereadable(l:realfile)
            l:dir = fnamemodify(l:realfile, ':h')
            execute 'lcd ' . fnameescape(l:dir)
            ProjectRootCD
         else
            ProjectRootCD
         endif
      endif
   catch
      " Silently ignore invalid buffers
   endtry
endfunction
autocmd BufEnter * call <SID>AutoProjectRootCD()

function! Get_lua_config_dir()
  let b:word = getline(line("."))
  if stridx(b:word, 'require') == -1
    if stridx(b:word, '~')
      let b:word = expand(strcharpart(b:word, stridx(b:word, '~')))
      if filereadable(b:word)
        return b:word
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
  return ""
endfunction

augroup luamap
  au BufEnter *.lua nmap <silent> gf :exe "e " . Get_lua_config_dir()<CR>
augroup END

