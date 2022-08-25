" setup plugin manager
call plug#begin('~/.local/share/vim/site/plugins')

source ~/.config/nvim/settings/functions.vim

if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
    Plug 'brettanomyces/nvim-editcommand'
    Plug 'honza/vim-snippets'
    Plug 'sbdchd/neoformat'
    Plug 'neomake/neomake'
    Plug 'jodosha/vim-godebug'
    Plug 'Shougo/context_filetype.vim'
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
end

" a list of plugins we want to have
" Plug 'Shougo/neosnippet-snippets'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'corntrace/bufexplorer'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'https://github.com/othree/xml.vim.git'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'sjl/gundo.vim'
Plug 'tmhedberg/matchit'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tpope/vim-unimpaired'
Plug 'zchee/deoplete-go'
" Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" Plug 'pechorin/any-jump.vim'
Plug 'tfnico/vim-gradle'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'OmniSharp/omnisharp-vim'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim'
Plug 'yasuhiroki/github-actions-yaml.vim'
Plug 'hashicorp/sentinel.vim'
Plug 'ojroques/vim-oscyank'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'tpope/vim-vinegar'
Plug 'wellle/targets.vim'
Plug 'rafamadriz/friendly-snippets',
Plug 'honza/vim-snippets',

" Plug 'JamshedVesuna/vim-markdown-preview'
" Plug 'roy2220/easyjump.tmux'
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
" Plug 'jpalardy/vim-slime'
" Plug 'majutsushi/tagbar'

" at the end, add plugins to the runtime path
call plug#end()
