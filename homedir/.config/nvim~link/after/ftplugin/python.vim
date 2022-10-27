setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab
setlocal autoindent
setlocal smartindent
setlocal colorcolumn=89

setlocal path=.,**
setlocal wildignore+=*.pyc

" pattern for include-search
setlocal include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\as\\)

" Set define jump expression
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

" Function for include expression
"
" import conv.metrics (1)
" /conv.metrics/
" conv/metrics.pyc
"
" from conv import conversion as conv (2)
" /conv import conversion/
" conv.conversion.py conv.py

function! PyInclude(fname)
  let parts = split(a:fname, ' imports ') " (1) [conv.metrics] (2) [conv, conversion]
  let l = parts[0] " (1) conv.metrics (2) conv

  if len(parts) > 1
    let r = parts[1] " conversion
    let joined = join([l, r], '.') " conv.conversion
    let fp = substitute(joined, '\.', '/', 'g') . 'py'
    let found = glob(fp, 1)

    if len(found)
      return found
    endif
  endif

  return substitute(l, '\.', '/', 'g') . 'py'
endfunction

setlocal includeexpr=PyInclude(v:fname)
