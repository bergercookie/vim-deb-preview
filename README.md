# deb-review

Current vim/neovim plugin offers an archive-like review of debian packages in
vim. There are multiple features, listed below that are still in progress.

## Usage:

Just point vim to a debian package and it will list its contents automatically
```
vim <path-to-debian-package.deb>
```

## Features

* View overall contents of a debian package.
* :construction: Navigate and inspect directories/files of the Debian package
* :construction: Edit the contents of a Debian package and repackage
    automatically on exit

## Prerequisites

* Platform: Linux Debian Flavors (Ubuntu, Debian etc.)
* dpkg-deb must be installed

## License

Current plugin is distributed under the same terms as Vim itself. See the
[LICENSE](https://github.com/bergercookie/vim-dpkg-preview/blob/master/LICENSE)
file

## Self Promotion

In case you like the plugin, you might as well [star it on
Github](https://github.com/bergercookie/vim-dpkg-preview) or [rate it on
vim.org](TODO) TODO. Also feel free to check my [other
plugins](https://github.com/bergercookie?tab=repositories)
