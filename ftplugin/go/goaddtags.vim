function! s:bytes_offset(line, col) abort
  if &encoding !=# 'utf-8'
    let l:sep = "\n"
    if &fileformat ==# 'dos'
      let l:sep = "\r\n"
    elseif &fileformat ==# 'mac'
      let l:sep = "\r"
    endif
    let l:buf = a:line ==# 1 ? '' : (join(getline(1, a:line-1), l:sep) . l:sep)
    let l:buf .= a:col ==# 1 ? '' : getline('.')[:a:col-2]
    return len(iconv(l:buf, &encoding, 'utf-8'))
  endif
  return line2byte(a:line) + (a:col-2)
endfunction

function! s:goaddtags(...)
  update
  let l:tags = join(split(a:000[0], '\s\+'), ',')
  let l:fname = expand('%:p')
  let l:cmd = printf('gomodifytags -file %s -offset %d --add-tags %s', shellescape(l:fname), s:bytes_offset(line('.'), col('.')), shellescape(l:tags))
  let l:out = system(l:cmd)
  let l:lines = split(substitute(l:out, "\n$", '', ''), '\n')
  if v:shell_error != 0
    echomsg join(l:lines, "\n")
    return
  endif
  let l:view = winsaveview()
  silent! %d _
  call setline(1, l:lines)
  call winrestview(l:view)
endfunction

command! -nargs=1 -buffer GoAddTags call s:goaddtags(<f-args>)
