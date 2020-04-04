if &shell =~# 'fish$' " ensure we use bash in order for vim work correctly
    set shell=zsh
endif
source ~/.config/nvim/settings/functions.vim
source ~/.config/nvim/settings/plugs.vim
source ~/.config/nvim/settings/disable_damian_plugins.vim
source ~/.config/nvim/settings/general.vim
source ~/.config/nvim/settings/keymaps.vim
source ~/.config/nvim/settings/taglist.vim
source ~/.config/nvim/settings/gundo.vim
source ~/.config/nvim/settings/vim-jedi.vim
source ~/.config/nvim/settings/vim-json.vim
source ~/.config/nvim/settings/vimux.vim
source ~/.config/nvim/settings/easy-align.vim
source ~/.config/nvim/settings/markdown.vim
source ~/.config/nvim/settings/ansible.vim
source ~/.config/nvim/settings/terminal.vim
" source ~/.config/nvim/settings/neoformat.vim
source ~/.config/nvim/settings/neosnippet.vim
source ~/.config/nvim/settings/vim-go.vim
source ~/.config/nvim/settings/tagbar.vim
source ~/.config/nvim/settings/ale.vim
source ~/.config/nvim/settings/fzf.vim
source ~/.config/nvim/settings/slim.vim
source ~/.config/nvim/settings/deoplete-go.vim
source ~/.config/nvim/settings/bash_support.vim
source ~/.config/nvim/settings/markdown_preview.vim
" source ~/.config/nvim/settings/nerdtree.vim
source ~/.config/nvim/settings/vim-terraform.vim

if has("nvim")
    source ~/.config/nvim/settings/deoplete.vim
    let g:python_host_skip_check = 1
    source ~/.config/nvim/settings/nvim_editcmd.vim
    " source ~/.config/nvim/settings/terraform-complete.vim
end
color Atelier_CaveDark
