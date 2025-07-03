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

map <leader>dt :diffsplit %%
imap <leader>dt <C-O>:diffsplit %%

map <leader>en :enew<CR>
imap <leader>en <C-O>:enew<CR>

map <leader>sz :sp term://zsh<CR>
imap <leader>sz <C-O>:sp term://zsh<CR>

" mapping for generating uuid into vim buffer
imap <leader>u <c-r>=system('uuid')<cr>

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
" WSL/Alacritty YAML paste with OSC52
if executable('uname') && system('uname -r') =~ "microsoft"
  function! OSC52YamlPaste()
     " First set paste mode to avoid autoindent during paste
     set paste
     " Get clipboard content through the configured clipboard provider
     let l:reg_content = getreg('*')
     execute "normal! i" . l:reg_content . "\<Esc>"
     " Restore paste mode
     set nopaste
     " Now fix the indentation of what was just pasted
     normal! `[v`]=
  endfunction

  " Override default paste in YAML files on WSL
  autocmd FileType yaml nnoremap <silent> p :call OSC52YamlPaste()<CR>
  autocmd FileType yaml nnoremap <silent> P :call OSC52YamlPaste()<CR>
endif

" The `NewSplit` function customizes the behavior of new splits for help, man,
" and fugitive buffers. It adjusts the split direction based on window width
" and sets a mapping to close the buffer with `q`. This function is triggered
" by an autocommand group `NewSplit` on the `WinNew` and `BufEnter` events.
fun! <SID>NewSplit()
   if (&bt ==? 'help' || &ft ==? 'man' || &ft ==? 'fugitive')
      " Check if this buffer has already been positioned
      if !exists('b:split_positioned')
         let b:split_positioned = 1
         let p = winnr('#')
         " Check if window is wide enough for side-by-side (horizontal width)
         if winwidth(p) >= getwinvar(p, '&tw', 80) + getwinvar(winnr(), '&tw', 80)
            set nosplitright
            exe 'wincmd ' . (&splitright ? 'L' : 'H')
            set splitright
         " Otherwise if window is tall enough, use a horizontal split
         elseif winheight(p) >= 20
            wincmd K
         endif
      endif
      nmap <buffer> q :norm! ZZ <CR>
   endif
endfun

" split help file vertically
aug NewSplit | au!
   au WinNew * au BufEnter * ++nested call <SID>NewSplit()
aug end

" The `Lookupwards` function searches upwards from the current cursor position
" for a non-whitespace character in the same column. It returns the character
" found, allowing for easy vertical copying. This is mapped to `Ctrl-Y` in insert mode.
function! LookNoneWhitespaceUpwards()
   let column_num      = virtcol( '.' )
   let target_pattern  = '\%' . column_num . 'v.'
   let target_line_num = search( target_pattern . '*\S', 'bnW' )

   " If target line found, return verticaly copied character ...
   let return_char = ""
   if target_line_num
      let return_char = matchstr( getline( target_line_num ), target_pattern )
   endif
   return return_char
endfunction
belent> <C-Y> <C-R><C-R>=LookNoneWhitespaceUpwards()<CR>

