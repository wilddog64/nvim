" The function uses `fnamemodify` to strip the last path component and a
" `substitute` command to handle edge cases.
function! s:RemoveLastPathComponent()
   let c = getcmdline()
   let cRoot = fnamemodify(c, ':r')
   if c == cRoot
      " Remove the last path component or trailing slash
      return substitute(
               \ c,
               \ '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$',
               \ '',
               \ ''
               \)
   endif
   return cRoot
endfunction

" remove trailing / by hitting control w -- map to s:RemoveLastPathComponent
" function
cnoremap <C-w> <C-\>e(<SID>RemoveLastPathComponent())<CR>

" The `FidgetWhitespace` function modifies a given pattern to handle
" whitespace more flexibly. It replaces trailing and leading whitespace with
" `\s*` and internal whitespace with `\_s\+`. This function is used in a
" visual mode mapping to search for patterns with flexible whitespace
" handling.
function! <SID>TrimOffWhitespaces(pat)
   let pat = substitute(a:pat,'\_s\+$','\\s\\*', '') " remove trailing whitespace
   let pat = substitute(pat, '^\_s\+', '\\s\\*', '') " remove leading whitespace
   return    substitute(pat,  '\_s\+', '\\_s\\+','g') " replace internal whitespace
endfunction
vmap <silent><leader>vs :<C-U>let @/="\\V<C-R>=escape(<SID>TrimOffWhitespaces(escape(@*,'\')),'\"')<CR>"<CR>

" The `Preserve` function saves the current search pattern and cursor
" position, executes a given command, and then restores the saved state. This
" is useful for commands that might disrupt the user's current context. It is
" mapped to `leader+=` to reformat the entire buffer without moving the
" cursor.
function! <SID>PreserveState(command)
   " save last search and cursor position
   let _s = @/
   let l = line(".")
   let c = col(".")

   " do our business here
   execute a:command

   " now restore search and cursor position
   let @/ = _s
   call cursor(l, c)
endfunction
nmap <leader>= :call <SID>PreserveState("normal gg=G")<CR>
nmap <leader>y :call <SID>PreserveState("='<,'>y")<CR>

" The `Lookupwards` function searches upwards from the current cursor position
" for a non-whitespace character in the same column. It returns the character
" found, allowing for easy vertical copying. This is mapped to `Ctrl-Y` in
" insert mode.
function! LookNoneWhitespaceUpwards()
   let column_num      = virtcol( '.' )
   let target_pattern  = '\%' . column_num . 'v.'
   let target_line_num = search( target_pattern . '*\S', 'bnW' )

   " If target line found, return verticaly copied character ...
   let return_char = ""
   if target_line_num
      let return_char = matchstr( getline( target_line_num ), target_pattern )
   endif
   return return_char
endfunction
imap <silent> <C-Y> <C-R><C-R>=LookNoneWhitespaceUpwards()<CR>

function! <SID>AutoProjectRootCD()
   try
      if &ft != 'help'
         ProjectRootCD
      endif
   catch
      " Silently ignore invalid buffers
   endtry
endfunction
autocmd BufEnter * call <SID>AutoProjectRootCD()

" strip trailing whitespaces without moving cursor
function! <SID>StripTrailingWhitespaces()
   " Preparation: save last search, and cursor position.
   call <SID>PreserveState("%s/\s\+$//e")
endfunction

nmap <silent> <leader>sw :call <SID>StripTrailingWhitespaces()<CR>
" autocmd BufWritePost * call <SID>StripTrailingWhitespaces()

function! Strip_patterns(input, patterns) abort
  " Apply multiple substitutions to an input string
  for pattern in a:patterns
    let a:input = substitute(a:input, pattern, '', 'g')
  endfor
  return a:input
endfunction

function! Replace_patterns(input, replacements) abort
  " Replace multiple patterns in the input string
  for [pattern, replacement] in items(a:replacements)
    let a:input = substitute(a:input, pattern, replacement, 'g')
  endfor
  return a:input
endfunction

" The `NewSplit` function customizes the behavior of new splits for help, man,
" and fugitive buffers. It adjusts the split direction based on window width
" and sets a mapping to close the buffer with `q`. This function is triggered
" by an autocommand group `NewSplit` on the `WinNew` and `BufEnter` events.
fun! <SID>NewSplit()
   if (&bt ==? 'help' || &ft ==? 'man' || &ft ==? 'fugitive')
      let p = winnr('#')
      " Check if window is wide enough for side-by-side (horizontal width)
      if winwidth(p) >= getwinvar(p, '&tw', 80) + getwinvar(winnr(), '&tw', 80)
         set nosplitright
         exe 'wincmd ' . (&splitright ? 'L' : 'H')
         set splitright
      " Otherwise if window is tall enough, use a horizontal split
      elseif winheight(p) >= 20
         wincmd K
      endif
      nmap <buffer> q :norm! ZZ <CR>
   endif
endfun

" split help file vertically
aug NewSplit | au!
   au WinNew * au BufEnter * ++nested call <SID>NewSplit()
aug end
