set omnifunc=ale#completion#OmniFunc

" configure ale for java
let g:ale_linters = {
  \ 'java': ['checkstyle', 'javac'],
\}
let g:ale_fixer = {
  \ 'java': ['google_java_format'],
\}
