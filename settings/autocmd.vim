augroup ansiblels
  au!
  au BufRead *.yaml,*.yml if stridx('%:p', 'tasks') && expand('%:e') == 'yml' | set ft=yaml.ansible | endif
augroup END
