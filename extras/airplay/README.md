# Get working airplay on Linux
In this directory a working config file has been provided for use with **Pipewire** to get working (audio) Airplay on your Linux machine. We need to place the config file in this directory `my-raop-discover.conf` in its own directory.
 
```
mkdir -p ~/.config/pipewire/pipewire.conf.d
cp my-raop-discover.conf ~/.config/pipewire/pipewire.conf.d/
```

After placing the file, log out and log back in and you should be able to see Airplay devices!

Alternatively you can restart pipewire, this method is untested.

```
systemctl --user daemon-reload
systemctl --user restart pipewire pipewire-pulse wireplumber
```