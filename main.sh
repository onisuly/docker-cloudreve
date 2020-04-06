#!/bin/sh
chown -R $PUID:$PGID /cloudreve
exec s6-setuidgid $PUID:$PGID /cloudreve/cloudreve
