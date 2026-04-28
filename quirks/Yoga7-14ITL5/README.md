## Kernel Arguments (Quirks)
For the Yoga 7 14ITL5, append the following kargs to fix sleep and performance issues:

```bash
rpm-ostree kargs --append='pci=nocrs' --append='intel_pstate=passive' --append='i8042.nopnp=1' --append='i2c_designware.timeout=5000' --append='processor.max_cstate=1' --append='pcie_aspm=off'
```

## Post-Sleep Input Fix (Touchpad & Pen)
If multi-touch gestures or the Wacom pen stop working after sleep or tablet-mode switches, run the installation script to deploy the automated fix:
1. `./install-touchpad-fix.sh`

**Note:** You can trigger a manual reset via GNOME shortcuts using:
`systemctl start touchpad-resume-fix.service`
