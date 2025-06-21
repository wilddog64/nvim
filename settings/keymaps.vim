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

" map control-s to save the buffer in normal, insert, and visual mode will update buffer to disk
noremap  <C-S>   :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" Allow undo for c-u and c-w in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

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

" only map Y if we are not using neovim
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

map <leader>en :enew<CR>
imap <leader>en <C-O>:enew<CR>

map <leader>sz :sp term://zsh<CR>
imap <leader>sz <C-O>:sp term://zsh<CR>

" mapping for generating uuid into vim buffer
imap <leader>u <c-r>=system('uuid')<cr>

" map <leader>fc to fake-credential.rb to generate a fake credential
imap <leader>fc <c-r>=system('~/.vim/bundle/fake-credential.rb')<cr>

" maps <leader>ap to AutoPairsToggle().  Allows one to enable/disable
" autopairs plugin a bit easier
imap <leader>ap <c-o>:call AutoPairsToggle()<cr>

map <leader>so :so $MYVIMRC<CR>

" map cp to transpose characters in normal mode
nmap <Plug>TransposeCharacters xp
nmap cp <Plug>TransposeCharacters

" keymap for resizing windows
nmap <C-Up> :resize -2<CR>
nmap <C-Down> :resize +2<CR>
nmap <C-Left> :vertical resize -2<CR>
nmap <C-Right> :vertical resize +2<CR>

" define line highlight color
highlight LineHighlight ctermbg=darkgray guibg=darkgray
" highlight the current line
nnoremap <silent> <Leader>h :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>c :call clearmatches()<CR>

" map C-K in insert mode to delete fromc urrent cursor postion to the end of
" line
imap <C-K> <C-O><S-D>

if has("nvim")
   nmap <leader>c <Plug>OSCYankOperator
   nmap <leader>cc <leader>c_
   vmap <leader>c <Plug>OSCYankVisual

   " map <leader>a to accept the word from copilot
   " imap <tab> <Plug>(copilot-accept-word)
   " imap <c-e> <Plug>(copilot-accept-line)

   let g:copilot_no_tab_map = v:true
   imap <Tab> copilot#Accept("\<CR>")
endif

