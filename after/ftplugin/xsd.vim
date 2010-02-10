function! xsd#CompleteTypes(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find months matching with "a:base"
        let res = []
        let types = ['ENTITIES', 'ENTITY', 'ID', 'IDREF', 'IDREFS', 'NCName',
                    \'NMTOKEN', 'NMTOKENS', 'NOTATION', 'Name', 'QName',
                    \'anyURI', 'base64Binary', 'boolean', 'byte', 'date',
                    \'dateTime', 'decimal', 'double', 'duration', 'float',
                    \'gDay', 'gMonth', 'gMonthDay', 'gYear', 'gYearMonth',
                    \'hexBinary', 'int', 'integer', 'language', 'long',
                    \'negativeInteger', 'nonNegativeInteger',
                    \'nonPositiveInteger', 'normalizedString',
                    \'positiveInteger', 'short', 'string', 'time', 'token',
                    \'unsignedByte', 'unsignedInt', 'unsignedLong',
                    \'unsignedShort']
        for m in types
            if m =~ '^' . a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfunction

set omnifunc=xsd#CompleteTypes
