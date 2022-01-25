" for neovim, use the built-in LSP, use ale only for code formatting
let g:ale_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\ 'ocaml': ['ocamlformat'],
\ 'go': ['gofmt'],
\ '*': ['remove_trailing_lines', 'trim_whitespace']
\}
