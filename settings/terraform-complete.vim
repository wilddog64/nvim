let g:terraform_completion_keys = 1
let g:syntastic_terraform_tffilter_plan = 1
let g:terraform_registry_module_completion = 1
let g:syntastic_terraform_tffilter_plan = 0
let g:deoplete#omni_patterns = {}
call deoplete#custom#option('omni_patterns', {
\ 'complete_method': 'omnifunc',
\ 'terraform': '[^ *\t"{=$]\w*',
\})

call deoplete#initialize()

