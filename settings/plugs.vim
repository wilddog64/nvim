" setup plugin manager
call plug#begin('~/.config/nvim/plugged')

source ~/.config/nvim/settings/functions.vim

" a list of plugins we want to have
" Plug 'JamshedVesuna/vim-markdown-preview'
" Plug 'Numkil/ag.nvim'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'aklt/plantuml-syntax'
" Plug 'burnettk/vim-jenkins'
" Plug 'derekprior/vim-trimmer'
" Plug 'jpalardy/vim-slime'
" Plug 'lepture/vim-jinja'
" Plug 'majutsushi/tagbar'
" Plug 'pearofducks/ansible-vim'
" Plug 'rodjek/vim-puppet'
" Plug 'scrooloose/nerdtree'
" Plug 'tommcdo/vim-exchange'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
" Plug 'WolfgangMehner/bash-support'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corntrace/bufexplorer'
Plug 'dag/vim-fish'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
" Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'https://github.com/othree/xml.vim.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jalvesaq/vimcmdline'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-go'
Plug 'hashivim/vim-terraform'

" Plug 'b4b4r07/vim-hcl'

if has("lua")
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/context_filetype.vim'
endif

if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
"   Plug 'brettanomyces/nvim-editcommand'
    Plug 'honza/vim-snippets'
    Plug 'sbdchd/neoformat'
    Plug 'neomake/neomake'
    Plug 'juliosueiras/vim-terraform-completion'
    Plug 'jodosha/vim-godebug'
    Plug 'Shougo/context_filetype.vim'
end
Plug 'vimlab/split-term.vim'

" at the end, add plugins to the runtime path
call plug#end()
