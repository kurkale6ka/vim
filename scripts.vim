if did_filetype()
    finish
endif

if getline(1) =~ '^#!\s*\%(text\|txt\)$'
    setf txt
endif
