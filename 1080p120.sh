#!/bin/bash
echo "🔧 Configuration : 1080p 120Hz + Fixes AMD..."

sudo rpm-ostree kargs --delete-if-present="video="
sudo rpm-ostree kargs --delete-if-present="amd_iommu="
sudo rpm-ostree kargs --delete-if-present="nomodeset"

sudo rpm-ostree kargs --append="amd_iommu=off" --append="nomodeset" --append="video=1920x1080@120e" --append="video=HDMI-A-1:1920x1080@120"

sleep 2 && sudo systemctl reboot
