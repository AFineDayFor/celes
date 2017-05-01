## Install
```bash
# I didn't care if my user lost existing files
cp -r /etc/skel/{*,.*} ~/
```
```bash
# You may.
for DERP in $(ls -l /etc/skel/);do
  [[ -z $HOME/$DERP ]]&&cp -r /etc/skel/$DERP ~/$DERP
done
```
## Uninstall
```bash
echo -e "\t- Have backups"
```
## General
### TIME
[ISO_8601](https://www.startpage.com/do/dsearch?query=ISO+8601)
## Screemshot
![Screenshot](screen.png)

