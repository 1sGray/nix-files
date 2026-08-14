#!/usr/bin/bash
# bus-is-finder.sh
for dev in /sys/class/drm/card*; do
  if [ -e "$dev/device" ]; then
    pci=$(basename $(readlink -f "$dev/device"))
    vendor=$(cat "$dev/device/vendor" 2>/dev/null)
    echo "$dev -> PCI $pci (vendor $vendor)"
  fi
done
