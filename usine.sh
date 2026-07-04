#!/bin/bash
OLD_VIDEO=$(rpm-ostree kargs | tr ' ' '\n' | grep '^video=')
# On force le 1080p@60 avec le 'e' pour activer la sortie en 16:9
if [ ! -z "$OLD_VIDEO" ]; then 
    sudo rpm-ostree kargs --replace="$OLD_VIDEO=video=1920x1080@60e"
else 
    sudo rpm-ostree kargs --append="video=1920x1080@60e"
fi
echo "✅ Résolution 1080p 16:9 forcée. Redémarrage..." && sleep 2 && sudo systemctl reboot
