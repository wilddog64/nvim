" execute a shell command and send output to vim buffer
if version >= 730
    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    function! s:RunShellCommand(cmdline)
      botright new
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
      call setline(1, a:cmdline)
      call setline(2, substitute(a:cmdline, '.', '=', 'g'))
      execute 'silent $read !' . escape(a:cmdline, '%#')
      setlocal nomodifiable
      l
    endfunction
endif

" remove trailing / by hitting control t
cnoremap <C-t> <C-\>e(<SID>RemoveLastPathComponent())<CR>
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

if version >= 730
    function! Preserve(command)
        " save last search and cursor position
        let _s = @/
        let l = line(".")
        let c = col(".")

        " do our business here
        execute a:command

        " now restore search and cursor position
        let @/ = _s
        cursor(l, c)
    endfunction
    nmap <leader>$ :call Preserve("%s/\s\+$//g")<CR>
    nmap <leader>= :call Preserve("normal gg=G")<CR>
endif

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

    return module_name
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

" a function that will build a markdown composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction
