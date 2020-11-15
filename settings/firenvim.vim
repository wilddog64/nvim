if !exists('g:started_by_firenvim')
    finish
endif

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['https://studio.youtube.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://instagram.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://twitter.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*gmail.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://.*twitch.tv.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://linkedin.com'] = { 'takeover': 'never', 'priority': 1 }

augroup firenvim
    autocmd!

    au BufEnter github.com_*.txt set filetype=markdown
    au BufEnter txti.es_*.txt set filetype=typescript
augroup END


