
function! unite#sources#outline#squirrel#outline_info()
    return s:outline_info
endfunction

let s:Util = unite#sources#outline#import('Util')

"----------------------------------------
" outline info

let s:outline_info = {
      \ 'heading'  : '^\s*\%(local\s\+\)\=function\s\+\h',
      \ 'skip'     : {
      \   'line'  : ['//'],
      \   'block' : ['/*', '*/'],
      \ },
      \ 'highlight_rules': [
      \     { 'name'     : 'function',
      \       'pattern'  : '/\h\w*/' },
      \ ]
      \}

function! s:outline_info.create_heading(which, heading_line, matched_line, context)
    let h_lnum = a:context.heading_lnum
    let level = s:Util.get_indent_level(a:context, h_lnum)

    let heading = {
        \ 'word' : a:heading_line,
        \ 'level': level,
        \ 'type' : 'generic',
        \ }

    let suffix = ''
    if heading.word =~ '\<local\>'
        let suffix = ' : local'
    end

    let heading.word = substitute(heading.word, '^\s*\%(local\s\+\)\=function\s\+', '', '') . suffix

    return heading
endfunction

