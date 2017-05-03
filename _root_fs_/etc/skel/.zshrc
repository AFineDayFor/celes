#paths
PATH="$PATH:/bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.gem/ruby/2.3.0/bin:$HOME/bin:$HOME/.node_modules/bin:$GOBIN:/usr/lib/ccache/bin/:$HOME/.dynamic-colors/bin:$HOME/dev/pl/perl5/bin"
MANPATH="/usr/local/man:$MANPATH"
PERL5LIB="$HOME/dev/pl/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
PERL_LOCAL_LIB_ROOT="$HOME/dev/pl/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
PERL_MB_OPT="--install_base \"$HOME/dev/pl/perl5\""
PERL_MM_OPT="INSTALL_BASE=$HOME/dev/pl/perl5"
CCACHE_DIR=$TMPDIR/ccache
# eyecandy
eval $(dircolors -b $HOME/.dircolors)
eval $(thefuck --alias fck)
dynamic-colors init
plugins=(archlinux zsh-navigation-tools)
TERM=rxvt-unicode
SHELL=/bin/zsh
ZSH=/usr/share/oh-my-zsh
EDITOR=nvim
VISUAL=less
BROWSER=chromium
GOPATH=$HOME/dev/go
GOBIN=$GOPATH/bin
npm_config_prefix=$HOME/.node_modules
LC_ALL=fr_FR.utf8
QT_STYLE_OVERRIDE='gtk2'
QT_QPA_PLATFORMTHEME='gtk2'
TMPDIR=$HOME/scratch
GPG_TTY=$(tty)
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="enable"
UPDATE_ZSH_DAYS=0
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$TMPDIR/zsh_history
HISTSIZE=56
SAVEHIST=$HISTSIZE
ZSH_CUSTOM=/etc/profile.d/
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
