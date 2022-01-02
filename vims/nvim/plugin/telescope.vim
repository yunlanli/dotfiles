" file pickers
nnoremap <leader>pf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>pg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>pb <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>pc <cmd>lua require('yunlan.telescope').search_dotfiles()<cr>

" lsp pickers
nnoremap <leader>ps <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>pr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>pd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>

" git pickers
nnoremap <leader>gf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gt <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_stash()<cr>

" vim pickers
nnoremap <leader>pb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ph <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>pm <cmd>lua require('telescope.builtin').man_pages()<cr>
nnoremap <leader>po <cmd>lua require('telescope.builtin').oldfiles()<cr>
