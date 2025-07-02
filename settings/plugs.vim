" setup plugin manager
call plug#begin('~/.local/share/vim/site/plugins')

source ~/.config/nvim/settings/functions.vim

" Plug 'artur-shaik/vim-javacomplete2'
" Plug 'OmniSharp/omnisharp-vim'
" Plug 'fatih/vim-go'
" Plug 'hashicorp/sentinel.vim'
" Plug 'zchee/deoplete-go'
" Plug 'szw/vim-maximizer'
" Plug 'OmniSharp/omnisharp-vim'
" Plug 'hashicorp/sentinel.vim'
" Plug 'w0rp/ale'
" Plug 'zchee/deoplete-go'
" Plug 'rhysd/vim-lsp-ale'
" Plug 'majutsushi/tagbar'
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
" Plug 'https://github.com/othree/xml.vim.git'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'godlygeek/tabular'

" a list of plugins we want to have
Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corntrace/bufexplorer'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'ervandew/supertab'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'hashivim/vim-terraform'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'honza/vim-snippets',
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'markonm/traces.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mattn/vim-lsp-settings'
Plug 'ojroques/vim-oscyank'
Plug 'prabirshrestha/vim-lsp'
Plug 'preservim/vim-indent-guides',
Plug 'rafamadriz/friendly-snippets',
Plug 'rodjek/vim-puppet'
Plug 'tfnico/vim-gradle'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'voldikss/vim-floaterm'
Plug 'wellle/targets.vim'
Plug 'yasuhiroki/github-actions-yaml.vim'
Plug 'tpope/vim-surround'

Plug 'JamshedVesuna/vim-markdown-preview', {'for': 'markdown'}

" at the end, add plugins to the runtime path
call plug#end()
