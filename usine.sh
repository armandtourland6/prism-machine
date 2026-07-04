#!/bin/bash
echo "🔧 Configuration de l'affichage : 1080p 60Hz (Format Usine)..."

# Nettoyage des anciens kargs video pour éviter les conflits
sudo rpm-ostree kargs --delete-if-present="video="

# Injection de la nouvelle configuration propre (Universelle + HDMI AMD)
sudo rpm-ostree kargs --append="video=1920x1080@60e" --append="video=HDMI-A-1:1920x1080@60"

echo "✅ Résolution 1080p 16:9 configurée avec succès !"
echo "🔄 Redémarrage de la Prism Machine dans 3 secondes..."
sleep 3
sudo systemctl reboot
