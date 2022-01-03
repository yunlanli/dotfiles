let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
let g:bujo#window_width = 50

nmap <leader>ot <cmd>Todo<cr>

nmap <C-S> <Plug>BujoAddnormal
imap <C-S> <Plug>BujoAddinsert

nmap <C-Q> <Plug>BujoChecknormal
imap <C-Q> <Plug>BujoCheckinsert
