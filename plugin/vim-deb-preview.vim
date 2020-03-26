" deb-preview.vim - Preview debian packages
" Maintainer: Nikos Koukis <http://bergercookie.github.io/>
" Version:    0.1

" ------------------------------------------------------------------------------
" Introductory moves {{{1
if exists('g:loaded_deb_preview') || &compatible
  finish
endif
let g:loaded_deb_preview = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:vim_deb_preview_glob = "*.deb"

" ------------------------------------------------------------------------------
"  autocommands {{{1
augroup deb
    au!
    if has("unix")
        " au BufReadCmd  call deb#Read(expand("<amatch>"), 1)
    endif

    exe "au BufReadCmd " . g:vim_deb_preview_glob.' call deb#Browse(expand("<amatch>"))'
augroup END

" ------------------------------------------------------------------------------
" Restoration And Modelines {{{1
" vim: fdm=marker
let &cpo= s:save_cpo
unlet s:save_cpo
