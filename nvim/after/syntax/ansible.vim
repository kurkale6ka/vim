" Highlight an Ansible task's name:
"
"   - name: restart apache
"           --------------
"           ^

" I couldn't use \zs so I used \@<=
syntax match ansibleTaskName /\%(-\s\+name:\s\+\)\@<=.*/

highlight link ansibleTaskName Comment
" highlight ansibleTaskName guifg=#605958 guibg=NONE gui=NONE cterm=none
