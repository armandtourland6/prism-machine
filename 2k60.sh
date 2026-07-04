#!/bin/bash
echo "🔧 Configuration en 2K (1440p) 60Hz..."
OLD_VIDEO=$(rpm-ostree kargs | tr ' ' '\n' | grep '^video=')

if [ ! -z "$OLD_VIDEO" ]; then
    sudo rpm-ostree kargs --replace="$OLD_VIDEO=video=2560x1440@60"
else
    sudo rpm-ostree kargs --append="video=2560x1440@60"
fi
echo "✅ Fait ! Redémarrage dans 5 secondes..."
sleep 5
sudo systemctl reboot
