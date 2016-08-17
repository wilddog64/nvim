" tell Tlist plugin where to find ctags program
let g:Tlist_Ctags_Cmd     = '/usr/local/bin/ctags'
let g:Tlist_Show_one_File = 1 " show on Tlist per file
" set taglist property for perl-support to work with ctags
let g:tlist_perl_settings='perl;c:constants;l:labels;p:package;s:subroutines;d:POD'
