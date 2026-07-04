#!/bin/bash
echo "🔧 Configuration en 1080p 120Hz..."
OLD_VIDEO=$(rpm-ostree kargs | tr ' ' '\n' | grep '^video=')

if [ ! -z "$OLD_VIDEO" ]; then
    sudo rpm-ostree kargs --replace="$OLD_VIDEO=video=1920x1080@120"
else
    sudo rpm-ostree kargs --append="video=1920x1080@120"
fi
echo "✅ Fait ! Redémarrage dans 5 secondes..."
sleep 5
sudo systemctl reboot
