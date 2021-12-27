# My guix config

## Setup

### Pre-setup

``` shell
guix install curl
curl -fsSL https://starship.rs/install.sh > install.sh
bash install.sh -b $HOME/bin
```

Install doom emacs

``` shell
guix install emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
emacs ~/.doom.d/init.el
~/.emacs.d/bin/doom sync
```

Install TPM

``` shell
guix install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```


