set iskeyword+=-

let @r=":s/,\\zs\\s*/\\r/g\<cr>:s/\\s*\\ze[{}]/\\r/g\<cr>=`[j:s/[{;]\\zs\\s*/\\r/g\<cr>dd$=iB:nohlsearch\<bar>Tabularize css\<cr>``EB"
