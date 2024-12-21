" the following code allow (n)vim to show signs when perform a visual black operations
if !has("nvim") | finish | endif

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
