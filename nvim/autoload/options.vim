" Show options
function! options#show_values(verbose)

   let options = input('Options? ', '', 'option')

   if !empty(options)
      let optionsArr = split(options)

      if a:verbose == 0
         let command =         'set '.join(optionsArr, '? ').'?'
      else
         let command = 'verbose set '.join(optionsArr, '? ').'?'
      endif
      execute command

      call histadd(':', command)
   else
      set
   endif

endfunction
