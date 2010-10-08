" "" instead of ci" and ci'
function! CI_quotes (text)

    let my_changedtick = b:changedtick

    let nb_quotes  = strlen(substitute(getline('.'), "[^']", '', 'g'))
    let nb_qquotes = strlen(substitute(getline('.'), '[^"]', '', 'g'))

    while nb_quotes < 2 && nb_qquotes < 2 && search ('["'."']", 'c')

        let nb_quotes  = strlen(substitute(getline('.'), "[^']", '', 'g'))
        let nb_qquotes = strlen(substitute(getline('.'), '[^"]', '', 'g'))

    endwhile

    let save_cursor = getpos(".")

    if nb_quotes >= 2 && nb_qquotes >= 2

        " If before the first quote or double quote...
        if !search ('["' . "']", 'cbW', line('.'))

            " ...go to the first one
            call search ('["' . "']", 'cW', line('.'))
        endif

        if "'" == matchstr(getline('.'), "['".'"]', col('.') - 1)

            let quote_under_cursor = "'"
            let anti_quote         = '"'
        else
            let quote_under_cursor = '"'
            let anti_quote         = "'"
        endif

        " Not at EOL
        if col('.') + 1 != col('$')

            call setpos('.', save_cursor)

            let at_eol = 0
        else
            let at_eol = 1
        endif

        if empty(a:text)

            let my_text = input('Text: ')
        else
            let my_text = a:text
        endif

        if at_eol || !at_eol && search (quote_under_cursor, 'cnW', line('.'))

            execute 'normal ci' . quote_under_cursor . my_text . "\<esc>"
        else
            execute 'normal ci' . anti_quote . my_text . "\<esc>"
        endif

    elseif nb_quotes >= 2

        " Beyond EOL
        if col('.') >= col('$')

            call search("'", 'cbW', line('.'))
        endif

        normal ci'

        if my_changedtick != b:changedtick

            if empty(a:text)

                let my_text = input('Text: ')
            else
                let my_text = a:text
            endif

            normal l

            execute 'normal i' . my_text . "\<esc>"
        endif

    elseif nb_qquotes >= 2

        " Beyond EOL
        if col('.') >= col('$')

            call search('"', 'cbW', line('.'))
        endif

        normal ci"

        if my_changedtick != b:changedtick

            if empty(a:text)

                let my_text = input('Text: ')
            else
                let my_text = a:text
            endif

            normal l

            execute 'normal i' . my_text . "\<esc>"
        endif
    endif

    if my_changedtick == b:changedtick

        echohl  ErrorMsg
        echo   'Nothing to do'
        echohl  None

        call setpos('.', save_cursor)
    else
        " Repeat
        let virtualedit_bak = &virtualedit
        set virtualedit=

        silent! call repeat#set(":call CI_quotes('" . my_text . "')\<cr>")

        let &virtualedit = virtualedit_bak
    endif

endfunction

nmap <silent> "" :call CI_quotes('')<cr>
