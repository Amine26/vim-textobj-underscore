if exists('g:loaded_textobj_underscore')
  finish
endif

call textobj#user#plugin('underscore', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'a_',  '*select-a-function*': 's:select_a',
\        'select-i': 'i_',  '*select-i-function*': 's:select_i'
\      }
\    })


function! s:select_a()
  let found_left = search('\(_\)\|\(\<\)', 'bcp', line('.')) == 2
  let left = getpos('.')

  let found_right = search('\(_\)\|\(.\ze\>\)', 'p', line('.')) == 2
  let right = getpos('.')

  if !found_left && !found_right
    return 0
  endif

  if found_left && found_right
    let right[2] -= 1
  endif

  return ['v', left, right]
endfunction


function! s:select_i()
  let found_left = search('\(_\zs.\)\|\(\<\)', 'bcp', line('.')) == 2
  let left = getpos('.')

  let found_right = search('\(.\ze_\)\|\(.\ze\>\)', 'cp', line('.')) == 2
  let right = getpos('.')

  if !found_left && !found_right
    return 0
  endif

  return ['v', left, right]
endfunction

let g:loaded_textobj_underscore = 1
