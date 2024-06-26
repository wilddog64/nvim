map <leader>vgb :VimuxRunCommand('git branch')<CR>
imap <leader>vgb <C-O>:VimuxRunCommand('git branch')<CR>
map <leader>vcl :VimuxRunCommand('clear')<CR>
imap <leader>vcl <C-O>:VimuxRunCommand('clear')<CR>
map <leader>ch :VimuxClearRunnerHistory<CR>
imap <leader>ch <C-O>:VimuxClearRunnerHistory<CR>
map <leader>vxl :VimuxRunLastCommand<CR>
imap <leader>vxl <C-O>:VimuxRunLastCommand<CR>
map <leader>vc :VimuxCloseRunner<CR>
imap <leader>vc <C-O>:VimuxCloseRunner<CR>

" execute a python module in current vim buffer.  This function
" depends on vimux plugin
function! <SID>ExecutePyModule()
    let b:filename = expand("%:r")     " file without extension

    " this only fits for python type script, reject any other
    if &ft != 'python'
        echom 'this meant only for python script'
        return
    endif

    " replace / with . so we can construct a full python module namespace
    let b:pymodule_namespace = substitute(b:filename, '\/', '.', 'g')

    " construct a command line to execute a python module, and execute it
    " let projectroot = projectroot#get()
    " execute "VimuxRunCommand('cd " . b:projectroot . "')"
    let b:execute_pymodule_cmd = 'python -m ' . b:pymodule_namespace
    echom 'executing: ' . b:execute_pymodule_cmd
    execute "VimuxRunCommand('" . b:execute_pymodule_cmd . "')"
endfunction

" maps <leader>xp to execute our custom module
augroup python
   au!
   autocmd FileType python map  <leader>xp :call <SID>ExecutePyModule()<CR>
   autocmd FileType python imap <python> <leader>xp <C-O>:call <SID>ExecutePyModule()<CR>
augroup END

function! <SID>SwitchToBufferDirRoot()
  let b:projectroot = projectroot#get(expand('%'))
  execute "VimuxRunCommand('cd " . b:projectroot . "')"
endfunction
map <leader>xcd :call <SID>SwitchToBufferDirRoot()<CR>
imap <leader>xcd <C-O>:call <SID>SwitchToBufferDirRoot()<CR>

map <leader>ir :VimuxInspectRunner<CR>       " inspect Runner pane
imap <leader>ir <C-O>:VimuxInspectRunner<CR> " inspect Runner pane
map <leader>vz :call VimuxZoomRunner()<CR>   " zoom runner pane for better examining
map <leader>vx :VimuxInterruptRunner<CR>     " interrupt current running panel
map <leader>vp :VimuxPromptCommand<CR>
" map <leader>ct :VimuxRunCommand('ctags -R')<CR> " execute ctags -R to generate or update tags file

" A function that will execute vagrant commands in tmux pane via
" VimuxRunCommand.  This function will also check to make sure Vagrantfile
" exist before it execute a given vagrant command.  It aborts if it can't find
" any Vagrantfile in current project root directory
" function! <SID>ExecuteVagrantCommand(command)
"   call <SID>SwitchToBufferDirRoot()
"   let projectroot = projectroot#get(expand('%'))
"   let vagrantfile = projectroot . '/Vagrantfile'
"   echom vagrantfile
"   if !empty(glob(vagrantfile))
"     let vagrantcmd = 'vagrant ' . a:command
"   else
"     echom 'no Vagrantfile exist, abort!'
"     return
"   endif
"   execute "VimuxRunCommand('" . vagrantcmd . "')"
" endfunction

" function! <SID>ExecuteTerraform(command)
"   call <SID>SwitchToBufferDirRoot()
"   let projectroot = projectroot#get(expand('%'))
"   let terraformdir = projectroot . '/.terraform'
"   echom 'terraform dir:' . terraformdir
"   lcd projectroot
"   let terraform_init = 'terraform init'
"   if empty(glob(terraformdir))
"       if input('initialize terraform?')
"           execute "VimuxRunCommand('" . terraform_init . "')"
"       endif
"   endif
" endfunction

" key mappings for some vagrant commands
" map  <leader>vau :call <SID>ExecuteVagrantCommand('up')<CR>
" imap <leader>vau <C-O>:call <SID>ExecuteVagrantCommand('up')<CR>
" map  <leader>vad :call <SID>ExecuteVagrantCommand('destroy -f')<CR>
" imap <leader>vad <C-O>:call <SID>ExecuteVagrantCommand('destroy -f')<CR>
" map  <leader>vap :call <SID>ExecuteVagrantCommand('provision')<CR>
" imap <leader>vap <C-O>:call <SID>ExecuteVagrantCommand('provision')<CR>
" map  <leader>vah :call <SID>ExecuteVagrantCommand('halt')<CR>
" imap <leader>vah <C-O>:call <SID>ExecuteVagrantCommand('halt')<CR>
" map  <leader>vag :call <SID>ExecuteVagrantCommand('plugin list')<CR>
" imap <leader>vag <C-O>:call <SID>ExecuteVagrantCommand('plugin list')<CR>
" map  <leader>vat :call <SID>ExecuteVagrantCommand('vagrant pristine -f')<CR>
" imap  <leader>vat <C-O>:call <SID>ExecuteVagrantCommand('vagrant pristine -f')<CR>
