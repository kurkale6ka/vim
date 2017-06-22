" syntax match ansibleTaskName /-\s\+name:\s\+\zs.*/ containedin=yamlPlainScalar
syntax match ansibleTaskName /-\s\+name:\s\+\zs.*/
hi ansibleTaskName guifg=#605958 guibg=NONE gui=NONE cterm=none
