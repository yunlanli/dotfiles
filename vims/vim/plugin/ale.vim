let g:ale_lint_on_save	= 1
let g:ale_fix_on_save	= 1

let g:ale_fixers = {
\   'ocaml': ['ocamlformat'],
\	'go': ['gofmt'],
\	'python': ['yapf'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
