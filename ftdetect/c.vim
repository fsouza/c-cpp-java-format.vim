autocmd FileType c setlocal noexpandtab
autocmd FileType c nmap <F5> :call FormatCCode()<CR>

function FormatCCode()
    silent %!indent
    silent %s/\s*$//
    ''
    silent %s/\v(}\n)([a-z])/\1\r\2/g
    ''
endfunction
