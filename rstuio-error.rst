
earlier, rstudio had missing library, ldd investigation notes:

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



x11vnc
        didn't cut it

lxde-settings-daemon lxde-common lxde-core lxde 

libxkbcommon-x11-dev

/usr/lib/rstudio/plugins/platforms/libqxcb.so,

Got keys from plugin meta data ("wayland-egl")
QFactoryLoader::QFactoryLoader() looking at "/usr/lib/rstudio/plugins/platforms/libqwayland-generic.so"
Found metadata in lib /usr/lib/rstudio/plugins/platforms/libqwayland-generic.so, metadata=
{
o
qterminal
lxqt/testing,unstable 30 amd64
  Metapackage for LXQt



~~~~

docker run --rm -p 8787:8787 -e PASSWORD=yourpasswordhere rocker/rstudio


docker build -t rocker/x11 .
XSOCK=/tmp/.X11-unix && XAUTH=/tmp/.docker.xauth && xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge - && docker run  -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH  -e DISPLAY=$DISPLAY --rm -it rocker/x11 R -e "capabilities()"

XSOCK=/tmp/.X11-unix && XAUTH=/tmp/.docker.xauth && xauth nlist :0 | sed -e "s/^..../ffff/" | xauth -f $XAUTH nmerge - && docker run  -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH  -e DISPLAY=$DISPLAY --rm -it tin6150/r4eta R -e "capabilities()"


https://github.com/rocker-org/rocker-versioned

maybe should just build my thing on top of their container...

actually, their stuff may have more features.
but i just had to `xhost +` for root to launch xter, qterminal, rstudio.

reorg the Dockerfile to have rstudio added at the bottom.
hmm... maybe not, since it works. 
more likely to need packages addition which beneficial to have it toward the end.

no need for lxde, lxqt 


~~~~

zink vs m42
both Mint 19.3

singularity exec myR rstudio	
	works on m42, launch gui app
	broken on zink.  maybe RandR/Xinerama/nvidia problem.
	xterm and qterminal runs on zink (rootless docker Mint 19.3), but crash when rstudio is launched.  Likely Xinerama or "RandR missing" issue.


docker ... rstudio
	broken for zink 
	m42... works: rootless docker issue, need to run as root, even if it is just fake uid 0.  this worked:
	docker run  -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/tmp/home  -p 8787:8787 -e PASSWORD=yourpasswordhere   --entrypoint rstudio tin6150/r4eta  



zink ssh -Y m42
	singularity exec myR xterm   # ok
	singularity exec myR rstudio # crash too, so it is really not liking the X server on Zink

