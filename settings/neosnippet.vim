let g:neosnippet#snippets_directory = expand("~/src/gitrepo/personal/vim/neosnippets")

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
