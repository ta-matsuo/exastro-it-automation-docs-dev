#!/bin/sh

version=`git branch --contains | cut -d " " -f 2`

if [ -f /tmp/install_talisman.bash ]; then
  bash /tmp/install_talisman.bash
fi
