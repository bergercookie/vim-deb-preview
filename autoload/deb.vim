" ------------------------------------------------------------------------------
fun! deb#CheckPrerequisites()
    if !executable("dpkg-deb")
        echoerr("Please install dpkg-deb first.")
        return 0  " falsy
    else
        return 1  " truthy
    endif
endfunction

" ------------------------------------------------------------------------------
" view contents - without manually unpacking {{{1
fun! deb#Browse(deb_file)
    if !deb#CheckPrerequisites()
        return 0
    endif

    let b:deb_contents_file = tempname() . "-vim-deb-preview"
    exe "e! " . b:deb_contents_file

    put="deb-preview.vim"
    call append(0, ['" deb-preview.vim',
                \   '" Browsing debian package: ' . a:deb_file,
                \   '" Select a file with cursor and press ENTER',
                \   '"'])

    " Put deb file contents + CONTROL
    let lnum = line(".")
    " redir => control_str
    " echom systemlist("dpkg-deb --info " . a:deb_file)
    " redir END
    " put=control_str
    " normal o
    exe "read !dpkg-deb --contents " . a:deb_file
    exe "normal " . lnum . "G"

    setlocal bufhidden=wipe noswapfile nobuflisted nomodified readonly
    setlocal filetype=netrw
    syntax enable

    " TODO Show CONTROL file as well
endfunction

fun! deb#CreateDebPackage(in_rootdir, out_deb)
    if !deb#CheckPrerequisites()
        return 0
    endif
    echoerr TODO

    " TODO - Remove md5sums file - recalculate it
endfunction

" ------------------------------------------------------------------------------
" Unpack the debian package - put all contents under the given out_rootdir {{{1
fun! deb#UnpackDebPackage(input_deb, out_rootdir)
    if !deb#CheckPrerequisites()
        return 0
    endif
    echoerr TODO
endfunction

" ------------------------------------------------------------------------------
" Open a file from the debian package {{{1
fun! deb#OpenFile(fname, readonly)
    if !deb#CheckPrerequisites()
        return 0
    endif
    let l:readonly = get(a:, 1, "on")
    echoerr TODO
endfunction

" ------------------------------------------------------------------------------
" Read a file from the debian package {{{1
fun! deb#ReadFile(fname)
    call deb#CheckPrerequisites()
    call deb#EditFile(fname)
endfunction

" ------------------------------------------------------------------------------
" TODO - Press dd to delete files {{{1

" ------------------------------------------------------------------------------
" TODO - Edit the control variables directly {{{1
