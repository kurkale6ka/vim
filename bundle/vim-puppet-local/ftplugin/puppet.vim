set tabstop=8
set includeexpr=substitute(v:fname,'.\\{-1,}/\\(.\\+\\)','../templates/\\1','')

augroup Puppet
  autocmd! BufReadCmd  puppet://* :execute 'edit'.(v:cmdbang?'!':'')
     \ v:cmdarg fnameescape('~/repos/operations/puppet/'.
     \expand('<afile>:gs?puppet:///\(modules.\{-1,}\)/\(.\+\)?\1/files/\2?'))
  autocmd! BufWriteCmd puppet://* :execute 'write'.(v:cmdbang?'!':'')
     \ v:cmdarg fnameescape('~/repos/operations/puppet/'.
     \expand('<afile>:gs?puppet:///\(modules.\{-1,}\)/\(.\+\)?\1/files/\2?'))
augroup END
