#/bin/bash
ANACRONDIR=~/.anacron
ANACRONTAB="$ANACRONDIR/etc/anacrontab"
ANACRONSPOOL="$ANACRONDIR/spool"
SCRIPT="$(pwd)/dconf-insurance.sh"

if grep "$SCRIPT" "$ANACRONTAB" >/dev/null 2>&1; then
        echo "Anacron job already configured."
        exit 1
fi

mkdir -p "${ANACRONDIR}/etc" "$ANACRONSPOOL"
echo "1 0 dconf-insurance $SCRIPT" >> $ANACRONTAB

if !(crontab -l | grep "$ANACRONDIR" >/dev/null); then
        TMPTAB=tmpcrontab
        crontab -l > $TMPTAB
        echo "0 * * * * /usr/sbin/anacron -t \"$ANACRONTAB\" -S \"$ANACRONSPOOL\"" >> $TMPTAB
        cat $TMPTAB | crontab -
fi

# vim: set nowrap
