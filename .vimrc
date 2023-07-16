syntax enable
colorscheme monokai
set autoindent expandtab tabstop=2 shiftwidth=2
set number
let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'yaml']
au BufNewFile,BufFilePre,BufRead *.note set filetype=markdown
set clipboard=unnamedplus
