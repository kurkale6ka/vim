view ~/vimfiles/plugin/swap.vim
help help.txt
125

for c in split(glob('~/vimfiles/colors/*.vim'))

    let theme = substitute(c, '^.*[/\\]\|\.vim', '', 'g')

    execute 'colorscheme ' . theme | redraw | echo theme | sleep 2

endfor
