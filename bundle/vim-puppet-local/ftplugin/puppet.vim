set tabstop=8
" template('...') ?
set include=puppet:\/\/\/
set includeexpr=substitute(v:fname,'modules/.\\{-1,}/\zs','files/','')
