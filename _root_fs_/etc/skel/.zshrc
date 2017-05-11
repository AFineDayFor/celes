# local
LC_ALL=fr_FR.utf8
#paths/export
GOPATH=$HOME/dev/go
GOBIN=$GOPATH/bi$$$$n
PATH="$PATH:/usr/lib/ccache/bin/:$HOME/.dynamic-colors/bin:$HOME/dev/pl/perl5/bin:$GOBIN"
CCACHE_DIR=$TMPDIR/ccache
plugins=(archlinux zsh-navigation-tools docker git)
SHELL=/bin/zsh
TERM=rxvt-unicode
EDITOR=nvim
VISUAL=$EDITOR
BROWSER=chromium
ZSH=/usr/share/oh-my-zsh
ZSH_CUSTOM=/etc/profile.d/
QT_STYLE_OVERRIDE='gtk2'
QT_QPA_PLATFORMTHEME='gtk2'
TMPDIR=$HOME/scratch
ENABLE_CORRECTION="false"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$TMPDIR/zsh_history
HISTSIZE=128
SAVEHIST=$HISTSIZE
# eyecandy
eval $(dircolors -b $HOME/.dircolors)
eval $(thefuck --alias fck)
dynamic-colors init
# oh-my-zsh
source $ZSH/oh-my-zsh.sh
# personal
source $HOME/.zsh_aliases
source $HOME/.zsh_functions
source $HOME/.zsh_profile
# prompt
autoload -Uz promptinit
promptinit
prompt off
