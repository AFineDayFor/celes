#!/usr/bin/env zsh
# X at login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach -t principale || tmux new-session -s principale)
fi
if [[ -n ${TMUX} && -n ${commands[tmux]}  ]];then
        case $(tmux showenv TERM 2>/dev/null) in
            *256color) ;&
            TERM=fbterm)
                    TERM=screen-256color ;;
            *)
                    TERM=screen
        esac
fi

