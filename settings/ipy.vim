let g:ipython_cell_prefer_external_copy = 1
let g:ipython_cell_highlight_cells = 0
"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default

" map <Leader>s to start IPython
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>
"
" " map <Leader>r to run script
nnoremap <Leader>r :IPythonCellRun<CR>
"
" map <Leader>R to run script and time the execution
nnoremap <Leader>R :IPythonCellRunTime<CR>
"
" " map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>
"
" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>
"
" " map <Leader>l to clear IPython screen
nnoremap <Leader>l :IPythonCellClear<CR>
"
" map <Leader>x to close all Matplotlib figure windows
nnoremap <Leader>x :IPythonCellClose<CR>
"
" " map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>
"
" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>h <Plug>SlimeLineSend
xmap <Leader>h <Plug>SlimeRegionSend
"
" " map <Leader>p to run the previous command
nnoremap <Leader>p :IPythonCellPrevCommand<CR>
"
" map <Leader>Q to restart ipython
nnoremap <Leader>Q :IPythonCellRestart<CR>
"
" " map <Leader>d to start debug mode
nnoremap <Leader>d :SlimeSend1 %debug<CR>
"
" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>q :SlimeSend1 exit<CR>
