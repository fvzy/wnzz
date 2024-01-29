FROM alpine:edge

ADD . /
COPY run_qemu /

RUN set -xe \
  && apk update \
  && apk add bash wget curl unzip

# Not using official url cause might give error
 RUN wget "https://dl.malwarewatch.org/windows/mods/Tiny10.iso" -O "windows.iso"

# Download using Anonfiles
# https://anonfiles.com/laS907C2y2/Tiny10_iso
# Download using Google Drive
# https://drive.google.com/uc?id=18ovKjHvhLa0bWUq5LJMNHxqtmdM1gOsw&export=download
# RUN chmod 755 gdrive.sh && \
#    wget --no-check-certificate -O "windows.iso" "$(./gdrive.sh 'https://drive.google.com/uc?id=18ovKjHvhLa0bWUq5LJMNHxqtmdM1gOsw&export=download')"

# Virt-io for Windows
 RUN wget "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.221-1/virtio-win.iso"

# Install Qemu
RUN apk add --no-cache qemu qemu-img qemu-system-x86_64 qemu-ui-gtk

# Install VNC
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  x11vnc novnc xvfb ttf-freefont \
  && ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html


EXPOSE 6080

RUN chmod 755 ./run_qemu

ENTRYPOINT ["bash", "run_qemu"]
