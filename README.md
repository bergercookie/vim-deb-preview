# deb-preview

```


     _      _                                _
  __| | ___| |__        _ __  _ __ _____   _(_) _____      __
 / _` |/ _ \ '_ \ _____| '_ \| '__/ _ \ \ / / |/ _ \ \ /\ / /
| (_| |  __/ |_) |_____| |_) | | |  __/\ V /| |  __/\ V  V /
 \__,_|\___|_.__/      | .__/|_|  \___| \_/ |_|\___| \_/\_/
                       |_|


```

## Description

I always loved the zip / tar plugins of vim, where you would just point vim to
an archive and it would show you its contents. However, there's nothing like
this when working with Debian packages even though they're not that different
than regular tarballs.

Current vim/neovim plugin offers an archive-like preview of Debian packages in
vim. On top of that it lets you edit the contents of the Debian package and if
it detects modifications, it repackages the Debian package and if it finds an
`md5sums` file in the package, recalculates all hashes and replaces that file.

## Usage:

Just point vim to a Debian package and it will list its contents automatically
```
vim <path-to-debian-package.deb>

```
## Demo

Here's a demo of the plugin, where I view a debian package, make a modification
to one of the files and then, on exit, `deb-preview` repackages the deb package
into `<original-name.deb>.new`.

![](/misc/demo.gif)

Here's also a demo of the plugin where I modify the metadata (CONTROL file)

![](/misc/demo2.gif)

## Features

* View contents of a Debian package.
* Navigate and inspect directories/files of the Debian package
* Edit the contents of a Debian package and repackage automatically on exit

## Options

```vim
" Set to 1 to overwrite .deb file in case of modifications [default=0]
let g:debpreview_overwrite = 1
" Set to the desired extension. deb-preview will use this extension when
" repackaging in case of modifications. In effect only when
" g:debpreview_overwrite if 0.
let g:debpreview_newdebfile_ext =".new"
```


## Installation

Platform: Linux Debian Flavors (Ubuntu, Debian etc.)

| Plugin manager | How to install |
| :------------- | :------------- |
| [Dein][1] | `call dein#add('bergercookie/vim-deb-preview')` |
| [minpac][2] | `call minpac#add('bergercookie/vim-deb-preview')` |
| [Pathogen][3] | `git clone https://github.com/bergercookie/vim-deb-preview.git ~/.vim/bundle/vim-deb-preview` |
| [Plug][4] | `Plug 'bergercookie/vim-deb-preview'` |
| [Vundle][5] | `Plugin 'bergercookie/vim-deb-preview'` |
| manual | copy all of the files into their corresponding directories under `.vim` directory (or `~/.config/nvim` if you're using neovim)|

[1]: https://github.com/Shougo/dein.vim
[2]: https://github.com/k-takata/minpac
[3]: https://github.com/tpope/vim-pathogen
[4]: https://github.com/junegunn/vim-plug
[5]: https://github.com/VundleVim/Vundle.vim

### Dependencies

debugstring depends on the following binaries on linux:

* `dpkg-deb`
* `fakeroot`
* `awk`
* `md5sum`

On ubuntu this should take care of the installation:

```
sudo apt install dpkg-deb fakeroot awk md5sum
```

## License

Current plugin is distributed under the same terms as Vim itself. See the
[LICENSE](https://github.com/bergercookie/vim-dpkg-preview/blob/master/LICENSE)
file

## TODO

- [ ] Handle error codes from `system()` commands
- [ ] Use fakeroot - handle permissions issue and verify it's working fine.

## Self Promotion

In case you like the plugin, you might as well [star it on
Github](https://github.com/bergercookie/vim-dpkg-preview) or [rate it on
vim.org](TODO) TODO. Also feel free to check my [other
plugins](https://github.com/bergercookie?tab=repositories)
