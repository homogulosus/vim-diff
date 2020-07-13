" =============================================================================
" Filename: plugin/diff.vim
" Author: homogulosus
" License: Same as Vim
" Last Change: Mon Jul 13 14:01:31 EDT 2020
" =============================================================================

if exists('g:loaded_diff')
  finish
endif
let g:loaded_diff = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? Diff call diff#Diff(<q-mods>, <q-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
