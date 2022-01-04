  function! s:list_commits()
    let git = 'git -C ' . getcwd()
    let commits = systemlist(git .' log --oneline | head -n10')
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
  endfunction

  let g:startify_lists = [
        \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
        \ { 'header': ['   Sessions'],       'type': 'sessions' },
        \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
        \ ]
