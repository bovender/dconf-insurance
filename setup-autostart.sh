#/bin/bash
AUTOSTART=~/.config/autostart
DESKTOPFILE=dconf-insurance.desktop

if [ -e "$AUTOSTART/$DESKTOPFILE" ]; then
        echo "Autostart already configured."
        exit 1
fi

mkdir -p ~/.config/autostart
pushd ~/.config/autostart >/dev/null
ln -s "$DESKTOPFILE"
popd >/dev/null
echo "Set up $DESKTOPFILE for autostart."
