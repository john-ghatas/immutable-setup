## Kernel Arguments (Quirks)
For the Yoga 7 14ITL5, append the following kargs to fix sleep and performance issues:

## Kargs
Add these kargs to your system to stabilize the Yoga 7i 14ITL5 on Linux.

### Legacy [Stable]
```bash
rpm-ostree kargs --append='pci=nocrs' --append='intel_pstate=passive' --append='intel_pstate=no_hwp' --append='i8042.nopnp=1' --append='i2c_designware.timeout=5000' --append='processor.max_cstate=1' --append='pcie_aspm=off'
```

### Modern
```bash
rpm-ostree kargs --append='pci=nocrs' --append='i8042.nopnp=1' --append='i2c_designware.timeout=2000' --append='intel_idle.max_cstate=1'
```

## Post-Sleep Input Fix (Touchpad & Pen)
If multi-touch gestures or the Wacom pen stop working after sleep or tablet-mode switches, run the installation script to deploy the automated fix:
1. `./install-touchpad-fix.sh`

**Note:** You can trigger a manual reset via GNOME shortcuts using:
`systemctl start touchpad-resume-fix.service`
