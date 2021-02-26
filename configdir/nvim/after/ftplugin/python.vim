set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

setlocal path=.,**
setlocal wildignore=*.pyc

for plugin in g:plugins
  if plugin == 'ale'
    nnoremap <silent> <F8> :ALEPreviousWrap<cr>
    nnoremap <silent> <F9> :ALENextWrap<cr>
  endif
endfor


" pattern for include-search
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\as\\)
"set include=\\v^\\s*\(from\|import\)\\s*\\zs\(\\S\\+\\s\\{-}\)*\\ze\($\|\as\)

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

  return substitute(joined, '\.', '/', 'g') . 'py'
endfunction

setlocal includeexpr=PyInclude(v:fname)

" Set define jump expression
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
"setlocal define=\\v^\\s*\<\(def\|class\)\>
