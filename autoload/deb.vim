" ------------------------------------------------------------------------------
" Utility functions {{{1
fun! deb#CheckPrerequisites() abort
    if !executable("dpkg-deb")
        echoerr("Please install dpkg-deb first.")
        return 0  " falsy
    endif

    if !executable("md5sum")
        echoerr("Please install md5sum first.")
        return 0
    endif

    if !executable("awk")
        echoerr("Please install awk first.")
        return 0
    endif
    return 1
endfunction

command! Echo echohl WarningMsg | echom <q-args> | echohl None

fun! deb#GetOutputName(name) abort
    if g:debpreview_overwrite
        return a:name
    else
        let name = a:name . g:debpreview_newdebfile_ext
        return name
    endif
endfunction

fun! deb#CalcDebDirHash(dir) abort
    let cmd = "find " . a:dir . " -type f -exec md5sum {} \\; | sort -k 2 | md5sum"
    return system(cmd)
endfunction

fun! deb#CalcFileHash(file) abort
    let cmd = "md5sum" . a:file
    return system(cmd)
endfunction

" ------------------------------------------------------------------------------
" View contents - without manually unpacking {{{1
fun! deb#Browse(deb_file) abort
    if !deb#CheckPrerequisites()
        return 0
    endif

    let s:deb_contents_root = tempname() . "-vim-deb-preview"

    call system("dpkg-deb -R " . a:deb_file . " " . " " . s:deb_contents_root)
    exe "e!" s:deb_contents_root

    let s:deb_output_name = deb#GetOutputName(a:deb_file)
    let s:orig_hash = deb#CalcDebDirHash(s:deb_contents_root)

    " Before exiting vim check whether the package contents have changed - if so
    " we should package it again
    augroup deb#Browse
        au!
        exe "autocmd ExitPre * call deb#CheckNCreateDebPackage('" . s:deb_contents_root . "','" . s:deb_output_name . "','" . s:orig_hash . "')"
    augroup end
endfunction

" ------------------------------------------------------------------------------
" Create debian package {{{1
fun! deb#CreateDebPackage(in_rootdir, out_deb) abort
    let md5sums_file = a:in_rootdir . "/DEBIAN/md5sums"
    if filereadable(md5sums_file)
        sleep 500m
        Echo "Rewriting md5sums..."
        call system("md5sum `find " . a:in_rootdir . " -type f | awk 'source/.\// { print substr($0, 3) }'` > " . a:in_rootdir . "/DEBIAN/md5sums")
    end

    sleep 500m
    Echo "Repacking debian package"
    call system("fakeroot dpkg-deb -b " . a:in_rootdir . " " . " " . a:out_deb)
endfunction

" ------------------------------------------------------------------------------
" Check if needed - then create debian package {{{1
fun! deb#CheckNCreateDebPackage(in_rootdir, out_deb, orig_hash) abort
    let s:curr_hash = deb#CalcDebDirHash(a:in_rootdir)
    if s:curr_hash ==# a:orig_hash
        sleep 500m
        echom "No changes detected"
        return
    endif

    call deb#CreateDebPackage(a:in_rootdir, a:out_deb)

    " move it someplace else
    call system("rm -rf " . a:in_rootdir)
endf
