" 2010-09-06
" map ctrl-return to open a line (for both normal and insert mode)
map <C-CR> o
imap <C-CR> <C-O>o

" map ctrl-shift-return for append at the end of line (for both normal and
" insert mode)
map <leader><CR>  o
imap <leader><CR> <C-O>o

" map ctrl-apple-return for adding a semi-colon at the end of line, and open a
" new line (both normal and insert mode)
map <C-D-CR> A;<CR>
imap <C-D-CR> <C-O>A;<CR>

" <leader>stf to add current timestamp
map <leader>stf <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>
imap <leader>stf <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>

" delete dup lines
map  <leader>ddl :%s/^\(.*\)\n\1/\1/<CR>           " remove duplicate lines
map  <leader>dd :g/\%(^\1$\n\)\@<=\(.*\)$/d<CR>    " remove duplicate lines -- different version
map  <leader>vdup :/^\(.*\)\(\r\?\n\1\)\+$<CR>
imap <leader>vdup <C-O>/^\(.*\)\(\r\?\n\1\)\+$<CR>

map <leader>gx yiw/^\(sub\<bar>function\)\s\+\w\+<CR>           " search sub or function declaractions in a buffer
map <leader>c :hi Normal guibg=#<c-r>=expand("<cword>")<cr><cr> " display rgb color under the cursor, eg #445588

" for working with taglist.vim plugin
noremap  <silent> <F2> <Esc><Esc>:TagbarToggle<CR>
inoremap <silent> <F2> <C-O>:TagbarToggle<CR>

" control-s in normal, insert, and visual mode will update buffer to disk
noremap  <C-S>   :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" so these mappings can allow us to undo c-u and c-w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" bring browser up by the following mappings
" set isfname-=? isfname+=?
" set isfname-=& isfname+=&
" let g:Browser_links="links"
" let g:Browser_camino="start -a Camino"
" let g:Browser_opera="start -a Opera"
" let g:Browser_firefox="start -a Firefox"
" let g:Browser_default="start "
" let g:Browser_chrome="start -a Google\ Chrome"
" nnoremap <silent> <leader>gl :exe("sil !" . g:Browser_console . " \"" . expand( "<cfile>" ) . "\"" )<CR>
" nnoremap <silent> <leader>gc :exe("sil !" . g:Browser_camino  . " \"" . expand( "<cfile>" ) . "\"" )<CR>
" nnoremap <silent> <leader>gd :exe("sil !" . g:Browser_default . " \"" . expand( "<cfile>" ) . "\"" )<CR>
" nnoremap <silent> <leader>go :exe("sil !" . g:Browser_opera   . " \"" . expand( "<cfile>" ) . "\"" )<CR>
" nnoremap <silent> <leader>gf :exe("sil !" . g:Browser_firefox . " \"" . expand( "<cfile>" ) . "\"" )<CR>
" nnoremap <silent> <leader>gh :exe("sil !" . g:Browser_chrome  . " \"" . expand( "<cfile>" ) . "\"" )<CR>

" compress empty lines
nnoremap <leader>cln :v/./.,/./-1join<CR>
imap <leader>cln <C-O>:v/./.,/./-1join<CR>

" tab and shift-tab keys to navigate buffers back and forth
" opt-tab and shift-opt-tab keys to navigate tab pages
map <TAB>   :bn!<CR>
map <S-TAB> :bp!<CR>

" map %% for command line to quickly edit file in current directory
cabbr %% e <C-R>=expand("%:p:h") . "/" <CR>

map <leader>tic :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
imap <leader>tic <C-O>:s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>

map Y y$ " Y will yank from cursor until EOL
" map <C-L> :noh<CR><C-L> " C-L will also clean up highlight, and redraw screen

" bump sequence number by 1 from current cursor location to the end
map <leader>bun :.,$s/\d\+/\=submatch(0) + 1/<CR>
imap <leader>bun <C-O>:.,$s/\d\+/\=submatch(0) + 1/<CR>

" edit key mapping
cnoremap %% <C-R>=expand("%:h") . '/'<CR>
map <leader>ee :e %%
imap <leader>ee <C-O>:e %%

map <leader>em :e $MYVIMRC<CR>
imap <leader>em <C-O>:e $MYVIMRC<CR>

map <leader>es :sp %%
imap <leader>es <C-O>:sp %%

map <leader>ev :vsp %%
imap <leader>ev <C-O>:vsp %%

map <leader>et :tabe %%
imap <leader>et <C-O>:tabe %%

map <leader>gt :GundoToggle<CR>
imap <leader>gt <C-O>:GundoToggle<CR>

map <leader>sz :sp term://zsh<CR>
imap <leader>sz <C-O>:sp term://zsh<CR>

map <leader>az :MaximizerToggle<CR>
imap <leader>az <C-O>:MaximizerToggle<CR>

" mapping for generating uuid into vim buffer
imap <leader>uid <c-r>=system('~/.vim/bundle/genuuid.py')<cr>

" map <leader>fc to fake-credential.rb to generate a fake credential
imap <leader>fc <c-r>=system('~/.vim/bundle/fake-credential.rb')<cr>

" maps <leader>ap to AutoPairsToggle().  Allows one to enable/disable
" autopairs plugin a bit easier
imap <leader>ap <c-o>:call AutoPairsToggle()<cr>

" mapping for navigating around tabs
map <leader>tn :tabn<CR>
imap <leader>tn <C-O>:tabn!<CR>
map <leader>tp :tabp<CR>
imap <leader>tp <C-O>:tabp!<CR>
map <leader>tf :tabfirst<CR>
imap <leader>tf :tabfirst!<CR>
map <leader>tl :tablast<CR>
imap <leader>tl :tablast<CR>

map <leader>so :so $MYVIMRC<CR>

" mappings for fugitive
map <leader>gdi :Gvdiffsplit<CR>
map <leader>gw  :execute 'Gwrite ' . expand('%') . '\| Gcommit'<CR>
map <leader>gst :Git status<CR>
map <leader>gpu :Git push<CR>

" map <leader>n :NERDTreeToggle<CR>

" mappings for vim-go
augroup vimgo
   au!
   au FileType go nmap <leader>gr :GoRun<CR>
   au FileType go imap <leader>gr <C-O>:GoRun<CR>
   au FileType go nmap <leader>gb :GoBuild<CR>
   au FileType go imap <leader>gb <C-O>:GoBuild<CR>
   au FileType go nmap <leader>gi :GoImport<CR>
   au FileType go imap <leader>gi <C-O>:GoImport<CR>
   au FileType go nmap <leader>gv :GoVet<CR>
   au FileType go imap <leader>gv <C-O>:GoVet<CR>
   au FileType go set ts=4
augroup END

" make transport 'xp' as one change rather than two
nmap <Plug>TransposeCharacters xp
nmap cp <Plug>TransposeCharacters

" keymap for resizing windows
nmap <C-Up> :resize -2<CR>
nmap <C-Down> :resize +2<CR>
nmap <C-Left> :vertical resize -2<CR>
nmap <C-Right> :vertical resize +2<CR>

nnoremap <silent><leader>gi :<Cmd>lua _LAZYGIT_TOGGLE()<cr><cr>
