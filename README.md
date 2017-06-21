Install
===


HowTo
===
Assumes `etc/skel` from `_root_fs_/` replaced any default `/etc/skel`, without error.
Also assumes more about env.

```bash
# I didn't care if my user lost existing files
cp -r /etc/skel/{*,.*} ~/
```

Assumes less
```bash
# You may
for DERP in $(ls -l /etc/skel/);do
  [[ -z $HOME/$DERP ]]&&cp -ri $HOME/$DERP{,.bak}&&cp -ir /etc/skel/$DERP $HOME/$DERP
done
```

Fix Time(`timedatectl`)
===
Be careful to replace the in-bracket text. Time can be general

```bash
timedatectl set-ntp 0
timedatectl set "[YYYY-MM-DD] [HH]:00:00"
timedatectl set-ntp 1
```

Uninstall
===
```bash
echo -e "\t- Have backups"
  [[ -z $HOME/$DERP ]]&&cp -ri $HOME/$DERP{.bak,}
```
## General
## Screenshot
![Screenshot](screen.png)
### TIME
[ISO_8601](https://www.startpage.com/do/dsearch?query=ISO+8601)
### KEYS
#### TMUX
`Ctrl+x`       : Prefix

`prefix+c`     : Create window

`prefix+g`     : Split H

`prefix+v`     : Split V

`prefix+,`     : Window previous

`prefix+.`     : Window next

`prefix+h`     : Window left

`prefix+j`     : Window up

`prefix+k`     : Window down

`prefix+l`     : Window right

#### DWM
`Meta+Shift+Return` : term(st)

`Meta+p`       : menu(run)

`Meta+Tab`     : menu(windows)

`Meta+Shift+w` : web(chromium)

`Meta+Shift+f` : filemanager(st -e ranger)

`Meta+Shift+q` : Quit

`Meta+Shift+c` : Toggl

`Meta+Shift+c` : Kill Client

`Meta+Shift+b` : Toggle Bar

`Meta+Ctrl+f`  : Toggle Float

`Meta+t`       : layout(tile)

`Meta+b`       : layout(bstack)

`Meta+m`       : layout(monocle)

`Meta+f`       : layout(float)
