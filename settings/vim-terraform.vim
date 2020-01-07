if has("nvim")
   let g:deoplete#omni_patterns = {}
   call deoplete#custom#option('omni_patterns', {
   \ 'complete_method': 'omnifunc',
   \ 'terraform': '[^ *\t"{=$]\w*',
   \})
   call deoplete#initialize()
   let g:terraform_align=1 " automatically format terraform"
endif
