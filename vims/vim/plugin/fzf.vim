let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = ['right:40%', 'ctrl-/']

nnoremap  <leader>o   :FzfFiles<CR>
nnoremap  <leader>O   :FzfFiles!<CR>
nnoremap  <leader>g   :FzfGFiles<CR>
nnoremap  <leader>G   :FzfGFiles?<CR>
nnoremap  <leader>s   :FzfTags<CR> 
nnoremap  <leader>t   "ayiW :FzfTags <c-r>a<CR>
