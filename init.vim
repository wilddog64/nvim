source ~/.config/nvim/settings/general.vim
source ~/.config/nvim/settings/plugs.vim
source ~/.config/nvim/settings/keymaps.vim
source ~/.config/nvim/settings/taglist.vim
source ~/.config/nvim/settings/gundo.vim
source ~/.config/nvim/settings/syntastics.vim
source ~/.config/nvim/settings/vim-jedi.vim
source ~/.config/nvim/settings/vim-json.vim
source ~/.config/nvim/settings/vimux.vim
source ~/.config/nvim/settings/easy-align.vim
source ~/.config/nvim/settings/markdown.vim
source ~/.config/nvim/settings/ansible.vim
source ~/.config/nvim/settings/terminal.vim
source ~/.config/nvim/settings/neoformat.vim
source ~/.config/nvim/settings/neosnippet.vim
source ~/.config/nvim/settings/vim-go.vim
if has("nvim")
    source ~/.config/nvim/settings/deoplete.vim
    let g:python_host_skip_check = 1
    source ~/.config/nvim/settings/nvim_editcmd.vim
    " source ~/.config/nvim/settings/terraform-complete.vim
end

" diff color settings
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

if has("nvim")
   set inccommand=nosplit
endif

" where to look for a private UltiSnips
let g:UltiSnipsSnippetsDir = expand("~/src/gitrepo/personal/ultisnips")

" these settings will make split windows on the right or bottom

" disable folding
let g:vim_markdown_folding_disabled = 1

" enable spelling check
set spell spelllang=en_us

colorscheme Atelier_HeathLight

let g:ruby_host_prog='/Users/cliang/.rbenv/versions/2.4.3/bin/ruby'
" let g:neocomplete#enable_at_startup = 1

let g:xml_use_xhtml = 1
