let g:vim_markdown_toc_autofix = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_mardown_conceal = 1
let g:vim_markdown_folding_disabled = 1
augroup markdown
   au!
   au Filetype markdown set conceallevel=2 concealcursor+=nc
augroup END
