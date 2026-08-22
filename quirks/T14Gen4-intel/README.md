## Kernel Arguments (Quirks)
For the Thinkpad T14 Gen 4 - this only concerns the fan curve setup and audio. To get it started you should implement the kargs via rpm-ostree.

```
rpm-ostree kargs --append='thinkpad_acpi.fan_control=1 pcie_port_pm=force nvme_core.default_ps_max_latency_us=5500 snd_hda_intel.power_save=1 snd_hda_intel.power_save_controller=Y usbcore.autosuspend=1 i915.force_probe=!a7a1 xe.force_probe=a7a1'
```

To add the tweaks necessary, run the `enable-thinkfan.sh` script and restart. After restart run the following command to enable the Thinkfan service so the fancurve is managed by the OS

```
sudo systemctl enable --now thinkfan
```

## BIOS Tweaks
The only bios tweak required to tie this script together is to disable the Always-On USB
