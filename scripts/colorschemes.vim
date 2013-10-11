" Use two text as examples for colorschemes...
view ~/vim/bundle/.swap/plugin/swap.vim
help help.txt
125

"... and preview all themes in ~/.vim/colors (2s pauses)
for c in split(glob('~/.vim/colors/*.vim'))

    let theme = substitute(c, '^.*[/\\]\|\.vim', '', 'g')
    execute 'colorscheme ' . theme | redraw | echo theme | sleep 2

endfor
