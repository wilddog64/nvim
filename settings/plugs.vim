" setup plugin manager
call plug#begin('~/.config/nvim/plugged')

source ~/.config/nvim/settings/functions.vim

" a list of plugins we want to have
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'corntrace/bufexplorer'
" Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
" Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
" Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'https://github.com/othree/xml.vim.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jalvesaq/vimcmdline'
Plug 'jiangmiao/auto-pairs'
" Plug 'lepture/vim-jinja'
" Plug 'majutsushi/tagbar'
" Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
" Plug 'rodjek/vim-puppet'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
" Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
" Plug 'zchee/deoplete-go'
Plug 'w0rp/ale'
" Plug 'derekprior/vim-trimmer'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/fzf.vim'
" Plug 'aklt/plantuml-syntax'
" Plug 'jpalardy/vim-slime'
Plug 'tmux-plugins/vim-tmux'
" Plug 'WolfgangMehner/bash-support'
" Plug 'JamshedVesuna/vim-markdown-preview'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'justinmk/vim-sneak'

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
    Plug 'hashivim/vim-terraform'
    Plug 'juliosueiras/vim-terraform-completion'
    Plug 'jodosha/vim-godebug'
    Plug 'Shougo/context_filetype.vim'
end
Plug 'vimlab/split-term.vim'

" at the end, add plugins to the runtime path
call plug#end()
