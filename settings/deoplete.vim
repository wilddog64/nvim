let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

" for complete java by using javacomplete2, and ultisnips plugins
let g:deoplete#sources = {}
let g:deoplete#sources.java = ['jc', 'javacomplete2', 'file', 'buffer', 'ultisnips']

call deoplete#enable() " enable deoplete
call deoplete#custom#option('smart_case', v:true)

inoremap <slinent> <CR> <C-r>=my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

