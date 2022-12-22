setlocal iskeyword-=:

setlocal tabstop=8
setlocal includeexpr=substitute(v:fname,'.\\{-1,}/\\(.\\+\\)','../templates/\\1','')

" g:puppet_modules_base_path must contain a / at the end
augroup PUPPET

  autocmd!

  " Use :preserve?
  autocmd BufReadCmd puppet://*
     \ execute 'keepalt edit'.(v:cmdbang?'!':'') v:cmdarg
     \ fnameescape(g:puppet_modules_base_path.
     \ expand('<afile>:gs?puppet:///\(modules.\{-1,}\)/\(.\+\)?\1/files/\2?')).
     \ '| bdelete #'

  autocmd BufWriteCmd puppet://*
     \ execute 'write'.(v:cmdbang?'!':'') v:cmdarg
     \ fnameescape(g:puppet_modules_base_path.
     \ expand('<afile>:gs?puppet:///\(modules.\{-1,}\)/\(.\+\)?\1/files/\2?'))

augroup END
