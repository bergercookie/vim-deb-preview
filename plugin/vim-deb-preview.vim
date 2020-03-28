" deb-preview.vim - Preview debian packages
" Maintainer: Nikos Koukis <http://bergercookie.github.io/>
" Version:    0.1

" ------------------------------------------------------------------------------
" Introductory moves {{{1
if exists('g:loaded_deb_preview') || &compatible
  finish
endif
let g:loaded_deb_preview = 1

if !has("unix")
    echoerr "Plugin must be executed on linux - sorry"
    finish
endif

let s:save_cpo = &cpoptions
set cpoptions&vim

" ------------------------------------------------------------------------------
" Options to tweak {{{1
let g:debpreview_overwrite = get(g:, "g:debpreview_overwrite", 0)
let g:debpreview_newdebfile_ext = get(g:, "g:debpreview_newdebfile_ext", ".new")
let g:debpreview_glob = get(g:, "g:debpreview_glob", "*.deb,*" . g:debpreview_newdebfile_ext)

" ------------------------------------------------------------------------------
"  autocommands {{{1
augroup deb
    au!
    exe "au BufReadCmd " . g:debpreview_glob.' call deb#Browse(expand("<amatch>"))'
augroup END

" ------------------------------------------------------------------------------
" Restoration And Modelines {{{1
" vim: fdm=marker
let &cpo= s:save_cpo
unlet s:save_cpo
