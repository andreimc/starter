Machine Bootstrap
=======

This aims to bootstrap my machine installing apps from:

App Store
Homebrew
Brew Cask

Ideally you should not need to install anything manually apart from command line tools for xcode so you can download the git repo.

Usage

APPLE_ID=user APPLE_PASS=password ./bootstrap.sh

It will propmpt you for password like sudo password a few times

After you install vim plugins you need to:

```
cd ~/.vim/bundle/YouCompleteMe
./install.py --all
```

this is no longer maintained see https://github.com/andreimc/machine_bootstrap
