if exists('g:asyncomplete_loaded')
    finish
endif
let g:asyncomplete_loaded = 1

let s:has_lua = has('lua') || has('nvim-0.2.2')

if get(g:, 'asyncomplete_enable_for_all', 1)
    augroup asyncomplete_enable
        au!
        au BufEnter * if exists('b:asyncomplete_enable') == 0 | call asyncomplete#enable_for_buffer() | endif
    augroup END
endif

let g:asyncomplete_manager = get(g:, 'asyncomplete_manager', 'asyncomplete#managers#vim#init')
let g:asyncomplete_change_manager = get(g:, 'asyncomplete_change_manager', ['asyncomplete#utils#_on_change#textchangedp#init', 'asyncomplete#utils#_on_change#timer#init'])
let g:asyncomplete_triggers = get(g:, 'asyncomplete_triggers', {'*': ['.', '>', ':'] })

let g:asyncomplete_auto_completeopt = get(g:, 'asyncomplete_auto_completeopt', 1)
let g:asyncomplete_auto_popup = get(g:, 'asyncomplete_auto_popup', 1)
let g:asyncomplete_completion_delay = get(g:, 'asyncomplete_completion_delay', 100)
let g:asyncomplete_default_refresh_pattern = get(g:, 'asyncomplete_default_refresh_pattern', '\(\k\+$\|\.$\|>$\|:$\)')
let g:asyncomplete_log_file = get(g:, 'asyncomplete_log_file', '')
let g:asyncomplete_smart_completion = get(g:, 'asyncomplete_smart_completion', s:has_lua && exists('##TextChangedP'))
let g:asyncomplete_remove_duplicates = get(g:, 'asyncomplete_remove_duplicates', 0)

" Setting it to true may slow/hang vim especially on slow are sources such as asyncomplete-lsp.vim
" use asyncomplete_force_refersh to retrive the latest autocomplete results instead.
" let g:asyncomplete_force_refresh_on_context_changed = get(g:, 'asyncomplete_force_refresh_on_context_changed', 0)

" imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <silent> <expr> <Plug>(asyncomplete_force_refresh) asyncomplete#force_refresh()
