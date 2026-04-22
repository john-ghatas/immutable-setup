The Yoga 7 14ITL5 has some known quirks that are solvable with additional kargs. The s0x sleep mode and track are known to cause some issues with regards to usability. To fix these append the following kargs:

```
rpm-ostree kargs --append='pci=nocrs' --append='intel_pstate=passive' --append='i8042.nopnp=1' --append='i2c_designware.timeout=5000 --append='processor.max_cstate=1' --append='pcie_aspm=off''
```
