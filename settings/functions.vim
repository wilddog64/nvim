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
function! Puppet_module_name()
   let module_path = expand("%:p:h:h") " figure full path for a given puppet module
   let search_char = '-'
   let pos = stridx( module_path, search_char )
   let module_name = ""
   if pos == -1
      let search_char = '_'
      let pos = stridx( module_path, search_char )
   endif
   if pos != -1
      let module_name = strpart( module_path, stridx( module_path, search_char ) + 1, strlen( module_path ) )
   endif

   return module_name
endfunction

" Get_puppet_module_name() calls Puppet_module_name() and also perform a
" sanity check to return a proper module name
function! Get_puppet_module_name()

   let module_name = Puppet_module_name()
   let basename = expand( "%:t:r" )
   if basename != 'init'
      let module_name = module_name . '::' . basename
   endif

   return strpart( module_name, stridx( module_name, '/' ) + 1, len( module_name ) )
endfunction

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

   " Get_puppet_manfiest_file is a function that return a full path of puppet
   " manifest, template, and upload file by interpretation of puppet statements
   function! Get_puppet_filepath()
      let puppetfile = expand("<cWORD>")
      if stridx(puppetfile, '::') != -1
         let puppetfile = Transfer_puppet_namespace2path()
      elseif stridx(puppetfile, 'template') != -1
         let puppetfile = Transfer_puppet_template2path()
      elseif stridx(puppetfile, 'puppet:') != -1
         let puppetfile = Transfer_puppet_modules2path()
      endif
      return puppetfile
   endfunction

   function! Transfer_puppet_namespace2path()
      let puppetfile = expand("<cWORD>") " obtain a WORD under the cursor
      if stridx(puppetfile, '::') == -1  " end function if we can't find ::
         return
      endif

      if match(puppetfile, ",$")
         let puppetfile = substitute(puppetfile, ",$", "", "")
      endif

      " if Class is found, strip it off
      if stridx(puppetfile, 'Class') != -1
         let puppetfile = substitute(puppetfile, '^Class', '', '')
      endif

      " if [ or ] is found, remove them
      if stridx(puppetfile, ']') != -1 || stridx(puppetfile, '[') != -1
         let puppetfile = substitute(puppetfile, '[', "", 'g')
         let puppetfile = substitute(puppetfile, ']', "", 'g')
      endif

      if stridx(puppetfile, 'create_resources') != -1
         let puppetfile = substitute(puppetfile, "^create_resources", '', '')
         let puppetfile = substitute(puppetfile, "(", "", "")
         let puppetfile = substitute(puppetfile, ")", "", "")
      endif

      if match(puppetfile, '^::')
         let puppetfile = substitute(puppetfile, "^::", "", "")
      endif
      " remove last character from string
      " strip off single quotes
      " replace :: with /
      " insert manifests after first found /
      " prepend ../ and append .pp
      if match( puppetfile, ":$" )
         " let puppetfile = strpart(puppetfile, 0, len(puppetfile) - 1)
         let puppetfile = substitute(puppetfile, ":$", "", "")
      endif
      let puppetfile = substitute(puppetfile, "'", "", "g")
      let puppetfile = substitute(puppetfile, '::', '\/', 'g')
      let puppetfile = substitute(puppetfile, '\/\zs', 'manifests\/', '')
      let puppetfile = '../' . puppetfile . '.pp'
      echom "module file path: " . puppetfile

      return puppetfile
   endfunction

   function! Transfer_puppet_template2path()
      let puppetfile = expand("<cWORD>")
      if stridx(puppetfile, 'template') == -1
         return
      endif
      if match(puppetfile, ",$")
         let puppetfile = substitute(puppetfile, ",$", "", "")
      endif

      let puppetfile = substitute(puppetfile, "template", "", "")
      let puppetfile = substitute(puppetfile, "(", "", "")
      let puppetfile = substitute(puppetfile, ")", "", "")
      let puppetfile = substitute(puppetfile, "'", "", "g")
      let puppetfile = substitute(puppetfile, '\/\zs', 'templates\/', '')
      let puppetfile = '../' . puppetfile
      echom "puppetfile :" . puppetfile
      return puppetfile
   endfunction

   function! Transfer_puppet_modules2path()
      let puppetfile = expand("<cWORD>")
      if stridx(puppetfile, "'") != -1
         let puppetfile = substitute(puppetfile, "'", "", "g")
      endif

      if match(puppetfile, ",$")
         let puppetfile = substitute(puppetfile, ",$", "", "")
      endif

      if stridx(puppetfile, 'puppet:') == -1
         return
      endif
      let puppetfile = substitute(puppetfile, "puppet:.*\/modules", "..", "")
      let puppetfile = substitute(puppetfile, '\(\w\+\)\ze\/', '\1\/files', '')
      return puppetfile
   endfunction

   " autocmd BufReadPost filetype puppet nmap <leader>gf :exe "e " . Get_puppet_manfiest_file()<CR>
   augroup puppetEx
      au!
      autocmd BufReadPost filetype puppet nmap <buffer> <leader>gf :exe "e "   . Get_puppet_filepath()<CR>
      autocmd BufReadPost filetype puppet nmap <buffer> <leader>wf :exe "sp "  . Get_puppet_filepath()<CR>
      autocmd BufReadPost filetype puppet nmap <buffer> <leader>vf :exe "vsp " . Get_puppet_filepath()<CR>
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


   " the following code allow (n)vim to show signs when perform a visual black operations
   augroup VisualSignShow
      autocmd!
      autocmd ModeChanged [\x16]*:i call s:ShowVisualBlock()
   augroup END

   sign define VisualSign text=> texthl=Visual

   let s:sign_ids = []
   function! s:ShowVisualBlock() abort
      for lnum in range(line("'<"), line("'>"))
         let id = sign_place(0, '', 'VisualSign', bufnr(), { 'lnum': lnum })
         call add(s:sign_ids, id)
      endfor

      autocmd InsertLeave * ++once call s:HideVisualBlock()
   endfunction

   function! s:HideVisualBlock() abort
      for id in s:sign_ids
         call sign_unplace('', { 'buffer': bufnr(), 'id': id })
      endfor

      let s:sign_ids = []
   endfunction
