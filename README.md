# mkosi configs for openSUSE MicroOS & Tumbleweed

This repository contains the needed config files and scripts to create openSUSE MicroOS and Tumbleweed images with `mkosi`. This images are raw disk or qcow2 images with a gpt partition table for systems or VMs with UEFI firmware. They contain a 1GB ESP partition and a root partition.
During firstboot the root partition is resized to a reasonable size and additional partitions like swap, /home or /var depending on the product are created.
Personalization is done via combustion or jeos-firstboot. Full disk encryption with TPM2 is supported.
All images can be build as normal user, no root rights are necessary.

## Building the images with mkosi

Required packages:
* mkosi >= 26
* python3-pefile
* systemd >= 259
* udev
* policycoreutils
* mtools
* qemu-img

### Command line

Change into the MicroOS or Tumbleweed directory and run `mkosi -f`.
Since `mkosi` requires some tools from `/usr/sbin`, the search path needs to be enhanced if the tool should run as normal user:

```sh
PATH=$PATH:/usr/sbin mkosi -f
```

This will build all images from the `<product>/mkosi.images` directory.

### OBS (Open Build Service)

There is a project which builds the images for openSUSE MicroOS and Tumbleweed:

* Project: https://build.opensuse.org/project/show/home:kukuk:mkosi-images
* Download: https://download.opensuse.org/repositories/home:/kukuk:/mkosi-images/mkosi/

To build the images in OBS, the `<product>/mkosi.conf` file needs to be replaced with `<product>/obs/mkosi.conf`.
