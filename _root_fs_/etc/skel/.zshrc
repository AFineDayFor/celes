# lang
LC_ALL=fr_FR.utf8
#paths/export
TMPDIR=${HOME}/scratch
GOPATH=${HOME}/dev/go
GOBIN=$GOPATH/bin
NPMPATH=${HOME}/dev/npm
NPMBIN=$NPMPATH/bin
PLPATH=${HOME}/dev/pl
PLBIN=$PLPATH/bin
RVMPATH=${HOME}/dev/rvm
RVMBIN=$NPMPATH/bin
PATH="$PATH:/usr/lib/ccache/bin/:${HOME}/.dynamic-colors/bin:$GOBIN:$NPMBIN:$PLBIN:$RVMBIN:${HOME}/bin"
CCACHE_DIR=$TMPDIR/ccache
# ZSH
plugins=(archlinux zsh-navigation-tools docker git)
SHELL=/bin/zsh
ZSH=/usr/share/oh-my-zsh
ZSH_CUSTOM=/etc/profile.d/
# applications
TERM=rxvt-unicode
BROWSER=chromium
EDITOR=nvim
VISUAL=$EDITOR
# QT/GTK
QT_STYLE_OVERRIDE='gtk2'
QT_QPA_PLATFORMTHEME='gtk2'
ENABLE_CORRECTION="false"
# history
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$TMPDIR/zsh_history
HISTSIZE=256
SAVEHIST=$HISTSIZE
# eyecandy
eval $(dircolors -b ${HOME}/.dircolors)
eval $(thefuck --alias fck)
dynamic-colors init
# resources
source $ZSH/oh-my-zsh.sh
source ${HOME}/.zsh_aliases
source ${HOME}/.zsh_functions
source ${HOME}/.zsh_profile
# prompt
autoload -Uz promptinit
promptinit
prompt off
