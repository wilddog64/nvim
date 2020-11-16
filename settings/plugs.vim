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
Plug 'Shougo/neosnippet-snippets'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corntrace/bufexplorer'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'hashivim/vim-terraform'
Plug 'https://github.com/othree/xml.vim.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'wilddog64/vim-unimpaired'
Plug 'zchee/deoplete-go'
Plug 'roy2220/easyjump.tmux'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'pechorin/any-jump.vim'
" Plug 'vim-airline/vim-airline'
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
