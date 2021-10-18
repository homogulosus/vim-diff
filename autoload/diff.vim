" =============================================================================
" Filename: autoload/diff.vim
" Author: homogulosus
" License: Same as Vim
" Last Change: Mon Jul 13 14:01:43 EDT 2020
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! diff#Diff(mods, spec) abort
    let mods = a:mods
    if !len(mods) && &diffopt =~# 'vertical'
      let mods = 'vertical'
    endif
    let cmd = '++edit #'
    if len(a:spec)
      let gitdir = finddir('.git', '.;')
      if empty(gitdir)
        echoerr 'no git dir found!'
        return 1
      else
        if !executable('git')
          echoerr 'no git executable found!'
          return 1
        else
          let cmd = "!git -C " . shellescape(fnamemodify(gitdir, ':p:h:h')) . " show " . a:spec . ":#"
        endif
      endif
    endif
    execute mods . ' new'
    setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
    execute "read " . cmd
    silent 0d_
    let &filetype = getbufvar('#', '&filetype')
    augroup Diff
      autocmd! * <buffer>
      autocmd BufWipeout <buffer> diffoff!
    augroup END
    diffthis
    wincmd p
    diffthis
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
