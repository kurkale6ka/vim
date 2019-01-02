augroup AFTER_FILETYPE_DETECT

   autocmd!
   autocmd BufNewFile,BufRead */*[aA]nsible*/roles/*/templates/*.json set filetype=json.jinja2

augroup END
