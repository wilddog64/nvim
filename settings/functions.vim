" remove trailing / by hitting control w
cnoremap <C-w> <C-\>e(<SID>RemoveLastPathComponent())<CR>
function! s:RemoveLastPathComponent()
   let c = getcmdline()
   let cRoot = fnamemodify(c, ':r')
   return (c != cRoot ? cRoot : substitute(c, '\%(\\ \|[\\/]\@!\f\)\+[\\/]\=$\|.$', '', ''))
endfunction

function! <SID>FidgetWhitespace(pat)
   let pat = substitute(a:pat,'\_s\+$','\\s\\*', '')
   let pat = substitute(pat, '^\_s\+', '\\s\\*', '')
   return    substitute(pat,  '\_s\+', '\\_s\\+','g')
endfunction
vmap <silent><leader>vs :<C-U>let @/="\\V<C-R>=escape(<SID>FidgetWhitespace(escape(@*,'\')),'\"')<CR>"<CR>

function! <SID>Preserve(command)
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
nmap <leader>= :call <SID>Preserve("normal gg=G")<CR>

" this vim function will return a actual puppet module name, assuming that
" delim is either - or _.  This function will strip off anything before - or _
" including delim character, and return anything after - or _.
" Lookupward function allow vim to copy vertical line above even if there's an
" empty line in between
function! Lookupwards()
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
imap <silent> <C-Y> <C-R><C-R>=Lookupwards()<CR>

" this function will relove symlink and follow it
function! <SID>FollowSymlink()
   let current_file = expand('%:p')
   " check if file type is a symlink
   if getftype(current_file) == 'link'
      " if it is a symlink resolve to the actual file path
      "   and open the actual file
      let actual_file = resolve(current_file)
      silent! execute 'file ' . actual_file
      end
   endfunction

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
      call <SID>Preserve("%s/\s\+$//e")
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

function! Puppet_module_name() abort
  let module_path = expand('%:p:h:h')  " Full path of the module
  let separators = ['-', '_']
  for sep in separators
    let pos = stridx(module_path, sep)
    if pos != -1
      return strpart(module_path, pos + 1)
    endif
  endfor
  return ''
endfunction

function! Get_puppet_module_name() abort
  let module_name = Puppet_module_name()
  let basename = expand('%:t:r')
  if basename != 'init'
    let module_name .= '::' . basename
  endif
  return substitute(module_name, '.*/', '', '')
endfunction

function! Get_puppet_filepath() abort
  let word = expand('<cWORD>')
  if stridx(word, '::') != -1
    return Transfer_puppet_namespace2path()
  elseif stridx(word, 'template') != -1
    return Transfer_puppet_template2path()
  elseif stridx(word, 'puppet:') != -1
    return Transfer_puppet_modules2path()
  endif
  return word
endfunction

function! Transfer_puppet_namespace2path() abort
  let word = expand('<cWORD>')
  if stridx(word, '::') == -1
    return ''
  endif

  let word = Strip_patterns(word, [',$', '^Class', '[\[\]]', '^::', ':$'])
  let word = Replace_patterns(word, {'::': '/', '/\zs': 'manifests/'})
  return '../' . word . '.pp'
endfunction

function! Transfer_puppet_template2path() abort
  let word = expand('<cWORD>')
  if stridx(word, 'template') == -1
    return ''
  endif

  let word = Strip_patterns(word, [',$', 'template', '\(|\)', "'"])
  let word = Replace_patterns(word, {'/\zs': 'templates/'})
  return '../' . word
endfunction

function! Transfer_puppet_modules2path() abort
  let word = expand('<cWORD>')
  let word = Strip_patterns(word, ["'", ',$', 'puppet:.*\/modules'])
  let word = Replace_patterns(word, {'/\zs': '/files'})
  return '../' . word
endfunction

augroup puppetEx
  au!
  autocmd BufReadPost *.pp nmap <buffer> <leader>gf :exe "e " . Get_puppet_filepath()<CR>
  autocmd BufReadPost *.pp nmap <buffer> <leader>wf :exe "sp " . Get_puppet_filepath()<CR>
  autocmd BufReadPost *.pp nmap <buffer> <leader>vf :exe "vsp " . Get_puppet_filepath()<CR>
augroup END

" split help file vertically
aug NewSplit | au!
   au WinNew * au BufEnter * ++once call <SID>NewSplit()
aug end

fun! <SID>NewSplit()
   if (&bt ==? 'help' || &ft ==? 'man' || &ft ==? 'fugitive')
      let p = winnr('#')
      if winwidth(p) >= getwinvar(p, '&tw', 80) + getwinvar(winnr(), '&tw', 80)
         set nosplitright
         exe 'wincmd ' . (&splitright ? 'L' : 'H')
         set splitright
      endif
   endif
   nmap q :norm! ZZ <CR>
endfun

function! GitStatus()
   let [a,m,r] = GitGutterGetHunkSummary()
   return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

