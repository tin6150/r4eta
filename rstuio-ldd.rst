
ubuntu vs debian release
https://askubuntu.com/questions/445487/what-debian-version-are-the-different-ubuntu-versions-based-on

bullseye/sid is base for ubuntu 20.04  -- current r4eta container
which doesn't have a Rstudio release for :(
https://rstudio.com/products/rstudio/download/#download

buster/sid is ubuntu 19.10 thru 18.04

trusty was 14.04 jessie/sid, so try at least newer Rstudio release for Ubuntu18/Debian 10
https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb



        libssl.so.1.0.0 => not found
        libcrypto.so.1.0.0 => not found

apt-file upgrade

apt-file find libQt5WebEngineWidgets.so.5

libqt5webenginewidgets5

root@01dbeae5aa63:/# ldd /usr/bin/rstudio
        linux-vdso.so.1 (0x00007ffe7b5e8000)
        libQt5WebEngineWidgets.so.5 => not found
        libQt5PrintSupport.so.5 => not found
        libQt5DBus.so.5 => not found
        libQt5WebEngineCore.so.5 => not found
        libQt5WebChannel.so.5 => not found
        libQt5Quick.so.5 => not found
        libQt5Network.so.5 => not found
        libQt5Widgets.so.5 => not found
        libQt5Gui.so.5 => not found
        libQt5Core.so.5 => not found
        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fa156069000)
        libutil.so.1 => /lib/x86_64-linux-gnu/libutil.so.1 (0x00007fa156062000)
        libuuid.so.1 => /lib/x86_64-linux-gnu/libuuid.so.1 (0x00007fa156059000)
        librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fa15604e000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fa156031000)
        libssl.so.1.0.0 => not found
        libcrypto.so.1.0.0 => not found
        libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fa155e62000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fa155d1d000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fa155d03000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fa155b40000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fa1568d0000)


qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, xcb.

