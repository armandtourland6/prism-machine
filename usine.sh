#!/bin/bash
echo "🔧 Réinitialisation de la console aux paramètres d'usine (1080p 60Hz)..."
OLD_VIDEO=$(rpm-ostree kargs | tr ' ' '\n' | grep '^video=')

if [ ! -z "$OLD_VIDEO" ]; then
    sudo rpm-ostree kargs --replace="$OLD_VIDEO=video=1920x1080@60"
else
    sudo rpm-ostree kargs --append="video=1920x1080@60"
fi
echo "✅ Fait ! Redémarrage dans 5 secondes..."
sleep 5
sudo systemctl reboot
