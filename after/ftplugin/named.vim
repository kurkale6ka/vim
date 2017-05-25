setlocal commentstring=#%s

setlocal includeexpr=substitute(v:fname,'^','/var/named/','')
