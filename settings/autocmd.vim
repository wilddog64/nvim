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

" content will be copy to clipboard
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif

" only load vim-lsp for these file types
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
