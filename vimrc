set nocp
if &shell =~# 'fish$' " ensure we use bash in order for vim work correctly
    set shell=zsh
endif

if !exists('g:vscode') " execute these if the context is not vscode

    source ~/.config/nvim/settings/functions.vim
    source ~/.config/nvim/settings/plugs.vim
    source ~/.config/nvim/settings/general.vim
    source ~/.config/nvim/settings/ale.vim
    source ~/.config/nvim/settings/ansible.vim
    source ~/.config/nvim/settings/asterisk.vim
    source ~/.config/nvim/settings/autocmd.vim
    source ~/.config/nvim/settings/deoplete-go.vim
    source ~/.config/nvim/settings/easy-align.vim
    source ~/.config/nvim/settings/firenvim.vim
    source ~/.config/nvim/settings/fzf.vim
    source ~/.config/nvim/settings/gundo.vim
    source ~/.config/nvim/settings/keymaps.vim
    source ~/.config/nvim/settings/markdown.vim
    source ~/.config/nvim/settings/markdown_preview.vim
    source ~/.config/nvim/settings/slim.vim
    source ~/.config/nvim/settings/supertab.vim
    source ~/.config/nvim/settings/tagbar.vim
    source ~/.config/nvim/settings/taglist.vim
    source ~/.config/nvim/settings/terminal.vim
    source ~/.config/nvim/settings/terraform-complete.vim
    source ~/.config/nvim/settings/ultisnips.vim
    source ~/.config/nvim/settings/vim-go.vim
    source ~/.config/nvim/settings/vim-jedi.vim
    source ~/.config/nvim/settings/vim-json.vim
    source ~/.config/nvim/settings/vim-terraform.vim
    source ~/.config/nvim/settings/vim_maximizer.vim
    source ~/.config/nvim/settings/vimux.vim
    source ~/.config/nvim/settings/floaterm.vim
    source ~/.config/nvim/settings/win32yank.vim
    source ~/.config/nvim/settings/lsp.vim
    " source ~/.config/nvim/settings/jenkins.vim
    " source ~/.config/nvim/settings/neoformat.vim
    " source ~/.config/nvim/settings/neosnippet.vim
    " source ~/.config/nvim/settings/nerdtree.vim
else
    " don't highlight search items
    set nohlsearch

    " call VSCodeCommentary on the visual selection, and then re-select that visual selection with gv
    xmap <C-/> <Plug>VSCodeCommentarygv
    nmap <C-/> <Plug>VSCodeCommentaryLine
    source ~/.vim/vimrc_minimal
end
