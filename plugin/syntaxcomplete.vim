if exists("s:loaded_syntaxcomplete")
    finish
endif

let s:loaded_syntaxcomplete = 1

if has("autocmd") && exists("+omnifunc")

    function ToggleSyntaxComplete()

        if exists('#syntaxcomplete#Filetype')

            autocmd! syntaxcomplete
            augroup! syntaxcomplete

        else

            augroup syntaxcomplete
                autocmd Filetype *
                    \ if &omnifunc == "" |
                    \ setlocal omnifunc=syntaxcomplete#Complete |
                    \ endif
            augroup END

        endif

    endfunction

    call ToggleSyntaxComplete()

endif
