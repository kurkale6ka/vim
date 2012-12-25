set path+=$HOME/repos/operations/puppet/
" template('...') ?
set include=puppet:\/\/\/
set includeexpr=substitute(v:fname,'modules/.\+\?\zs/','/files','')
