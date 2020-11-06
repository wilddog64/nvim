" setup plugin manager
call plug#begin('~/.config/nvim/plugged')

source ~/.config/nvim/settings/functions.vim

if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
    Plug 'brettanomyces/nvim-editcommand'
    Plug 'honza/vim-snippets'
    Plug 'sbdchd/neoformat'
    Plug 'neomake/neomake'
    Plug 'juliosueiras/vim-terraform-completion'
    Plug 'jodosha/vim-godebug'
    Plug 'Shougo/context_filetype.vim'
end

" a list of plugins we want to have
Plug 'zchee/deoplete-go'
Plug 'w0rp/ale'
" Plug 'vim-airline/vim-airline'
Plug 'wilddog64/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmhedberg/matchit'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'https://github.com/othree/xml.vim.git'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-hashicorp-tools'
" Plug 'godlygeek/tabular'
Plug 'fatih/vim-go'
Plug 'ervandew/supertab'
Plug 'dbakker/vim-projectroot'
Plug 'davidhalter/jedi-vim'
Plug 'corntrace/bufexplorer'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'Shougo/neosnippet-snippets'
Plug 'jpalardy/vim-slime'
" Plug 'godlygeek/tabular'
" Plug 'tpope/vim-rake'
" Plug 'tommcdo/vim-exchange'
" Plug 'scrooloose/nerdtree'
" Plug 'rodjek/vim-puppet'
" Plug 'pearofducks/ansible-vim'
" Plug 'lepture/vim-jinja'
" Plug 'justinmk/vim-sneak'
" Plug 'jalvesaq/vimcmdline'
" Plug 'elzr/vim-json'
" Plug 'derekprior/vim-trimmer'
" Plug 'dag/vim-fish'
" Plug 'burnettk/vim-jenkins'
" Plug 'aklt/plantuml-syntax'
" Plug 'WolfgangMehner/bash-support'
" Plug 'Shougo/denite.nvim'
" Plug 'JamshedVesuna/vim-markdown-preview'

" at the end, add plugins to the runtime path
call plug#end()
