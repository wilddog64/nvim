" setup plugin manager
call plug#begin('~/.config/nvim/plugged')

source ~/.config/nvim/settings/functions.vim

" a list of plugins we want to have
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'chiel92/vim-autoformat'
Plug 'corntrace/bufexplorer'
Plug 'davidhalter/jedi-vim'
Plug 'dbakker/vim-projectroot'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'jalvesaq/vimcmdline'
Plug 'jiangmiao/auto-pairs'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/vim-easy-align'
Plug 'lepture/vim-jinja'
Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
Plug 'saltstack/salt-vim'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmhedberg/matchit'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-perl/vim-perl'
Plug 'jsfaint/gen_tags.vim'
Plug 'flazz/vim-colorschemes'
Plug 'juneedahamed/vc.vim'
Plug 'https://github.com/othree/xml.vim.git'
Plug 'tfnico/vim-gradle'
Plug 'Shougo/denite.nvim'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'burnettk/vim-jenkins'
Plug 'rodjek/vim-puppet'
Plug 'vim-scripts/dbext.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'dhruvasagar/vim-open-url'
Plug 'zchee/deoplete-go'
Plug 'majutsushi/tagbar'

if has("lua")
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/context_filetype.vim'
endif

if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
    Plug 'brettanomyces/nvim-editcommand'
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
