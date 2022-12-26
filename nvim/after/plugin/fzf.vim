" Scriptnames
command! -nargs=? Scriptnames call fzf#run(fzf#wrap({
   \ 'source': split(execute('scriptnames'), '\n'),
   \ 'sink': {script -> execute('edit'.substitute(script, '^\s*\d\+:\s\+', '', ''))},
   \ 'options': '-1 +m -q "'.<q-args>.'" --prompt "Scriptnames> "'
   \ }))
