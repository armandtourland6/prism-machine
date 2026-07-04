#!/bin/bash
echo "🔧 Configuration en 4K UHD 120Hz..."
OLD_VIDEO=$(rpm-ostree kargs | tr ' ' '\n' | grep '^video=')

if [ ! -z "$OLD_VIDEO" ]; then
    sudo rpm-ostree kargs --replace="$OLD_VIDEO=video=3840x2160@120"
else
    sudo rpm-ostree kargs --append="video=3840x2160@120"
fi
echo "✅ Fait ! Redémarrage dans 5 secondes..."
sleep 5
sudo systemctl reboot
