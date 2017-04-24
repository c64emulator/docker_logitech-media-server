#!/bin/sh

if [ "$SQUEEZE_VOL" ] && [ -d "$SQUEEZE_VOL" ]; then
	for subdir in prefs logs cache; do
		mkdir -p $SQUEEZE_VOL/$subdir
		chmod 775 $SQUEEZE_VOL/$subdir
	done
	chmod 775 $SQUEEZE_VOL
	chown -R 888:888 $SQUEEZE_VOL
fi

# regular startup sequence, comment for testing
exec /start-squeezebox.sh "$@"

# uncomment for testing
#/bin/bash

