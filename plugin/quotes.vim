" "" instead of ci" and ci'
function! CI_quotes()

    let nb_quotes  = strlen(substitute(getline('.'), "[^']", '', 'g'))
    let nb_qquotes = strlen(substitute(getline('.'), '[^"]', '', 'g'))

    let changed_quotes = 0

    if nb_quotes >= 2 && nb_qquotes >= 2

        if search("'", 'cbn', line('.'))

            normal ci'
        else
            normal ci"
        endif

        let changed_quotes = 1

    elseif nb_quotes >= 2

        normal ci'

        let changed_quotes = 1

    elseif nb_qquotes

        normal ci"

        let changed_quotes = 1
    endif

    if changed_quotes

        normal l

        startinsert

        " Repeat
        let virtualedit_bak = &virtualedit
        set virtualedit=

        silent! call repeat#set(":call CI_quotes()\<cr>")

        let &virtualedit = virtualedit_bak
    endif

endfunction

nmap <silent> "" :call CI_quotes()<cr>
