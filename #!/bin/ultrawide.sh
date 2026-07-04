#!/bin/bash
echo "🔧 Configuration en Ultrawide 1440p 60Hz..."
OLD_VIDEO=$(rpm-ostree kargs | tr ' ' '\n' | grep '^video=')

if [ ! -z "$OLD_VIDEO" ]; then
    sudo rpm-ostree kargs --replace="$OLD_VIDEO=video=3440x1440@60"
else
    sudo rpm-ostree kargs --append="video=3440x1440@60"
fi
echo "✅ Fait ! Redémarrage dans 5 secondes..."
sleep 5
sudo systemctl reboot
