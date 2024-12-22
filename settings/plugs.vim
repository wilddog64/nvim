" setup plugin manager
call plug#begin('~/.local/share/vim/site/plugins')

source ~/.config/nvim/settings/functions.vim

" a list of plugins we want to have
" Plug 'OmniSharp/omnisharp-vim'
Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
" Plug 'artur-shaik/vim-javacomplete2'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corntrace/bufexplorer'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'ervandew/supertab'
" Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
" Plug 'hashicorp/sentinel.vim'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'hashivim/vim-terraform'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'honza/vim-snippets',
Plug 'https://github.com/othree/xml.vim.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ojroques/vim-oscyank'
" Plug 'zchee/deoplete-go'
" Plug 'szw/vim-maximizer'
Plug 'tfnico/vim-gradle'
Plug 'artur-shaik/vim-javacomplete2'
" Plug 'OmniSharp/omnisharp-vim'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim'
Plug 'yasuhiroki/github-actions-yaml.vim'
" Plug 'hashicorp/sentinel.vim'
Plug 'ojroques/vim-oscyank'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'tpope/vim-vinegar'
Plug 'voldikss/vim-floaterm'
" Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'yasuhiroki/github-actions-yaml.vim'
" Plug 'zchee/deoplete-go'
Plug 'rodjek/vim-puppet'
Plug 'prabirshrestha/vim-lsp'
" Plug 'rhysd/vim-lsp-ale'
Plug 'mattn/vim-lsp-settings'
Plug 'voldikss/vim-floaterm'
Plug 'rafamadriz/friendly-snippets',
Plug 'honza/vim-snippets',
Plug 'markonm/traces.vim'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
" Plug 'majutsushi/tagbar'

Plug 'JamshedVesuna/vim-markdown-preview', {'for': 'markdown'}
" Plug 'Shougo/denite.nvim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'WolfgangMehner/bash-support'
" Plug 'aklt/plantuml-syntax'
" Plug 'burnettk/vim-jenkins'
" Plug 'dag/vim-fish'
" Plug 'derekprior/vim-trimmer'
" Plug 'elzr/vim-json'
" Plug 'jalvesaq/vimcmdline'
" Plug 'jpalardy/vim-slime'
" Plug 'justinmk/vim-sneak'
" Plug 'lepture/vim-jinja'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'pearofducks/ansible-vim'
" Plug 'pechorin/any-jump.vim'
" Plug 'puremourning/vimspector'
" Plug 'roy2220/easyjump.tmux'
" Plug 'scrooloose/nerdtree'
" Plug 'tommcdo/vim-exchange'
" Plug 'tpope/vim-rake'
" Plug 'vim-airline/vim-airline'

" at the end, add plugins to the runtime path
call plug#end()
