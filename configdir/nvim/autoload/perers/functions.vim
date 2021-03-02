
" Trim trailing whitespace
    function! perers#functions#trim_trailing_whitespace()
        if search('\s\+$', 'cnw')
            :%s/\s\+$//ge
        endif
    endfunction


" Toggle foldmethod
    function! perers#functions#toggle_fold()
        if g:FoldMethod == 0
            exe 'set foldmethod=indent'
            let g:FoldMethod = 1
        else
            exe 'set foldmethod=marker'
            let g:FoldMethod = 0
        endif
    endfunction


" Cycle through relativenumber + number, number (only), and no numbering.
    function! perers#functions#cycle_numbering() abort
        if exists('+relativenumber')
            execute {
                \ '00': 'set relativenumber   | set number',
                \ '01': 'set norelativenumber | set number',
                \ '10': 'set norelativenumber | set nonumber',
                \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
        else
            " No relative numbering, just toggle numbers on and off.
            set number!
        endif
    endfunction


" Toggle quickfix list
    augroup QuickfixToggle
        au!
        au BufReadPost quickfix let g:qfix_list = 1
        augroup END

    function! perers#functions#toggle_quickfix_list()
        if exists("g:qfix_list")
            cclose
            unlet g:qfix_list
        else
            let g:qfix_list = 1
            copen
        endif
    endfunction


" Toggle locallist
    function! perers#functions#toggle_location_list()
        if get(getloclist(0, {'winid':0}), 'winid', 0)
            lclose
        else
            lopen
        endif
    endfunction

" Close all netrw buffers
    function! perers#functions#close_explorer_buffers()
        for i in range(1, bufnr('$'))
            if getbufvar(i, '&filetype') == "netrw"
                silent exe 'bdelete! ' . i
            endif
        endfor
    endfunction

" Sync cliboard from over ssh session with operating system command 52
   function! Osc52Yank()
       let buffer=system('base64', @0)
       let buffer=substitute(buffer, "\n", "", "")
       let buffer='\e]52;c;'.buffer.'\e\'
       silent execute "!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
    endfunction
