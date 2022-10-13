# Windows Qemu

```
docker build -t windows_vnc .
```

```
docker rm windows_vnc_container
docker run --name windows_vnc_container -p 6080:6080 windows_vnc
# docker run --name windows_vnc_container -p 6080:6080 windows_vnc -d 
```

```
rm -fr ngrock* && wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && tar -xvf ngrok-v3-stable-linux-amd64.tgz && rm ngrok-v3-stable-linux-amd64.tgz && chmod 755 ./ngrock

./ngrok config add-authtoken 2F04Bi81faMulXxITLnzKqzsnA3_3N54dUu9EdhpsVZU2k6KS
./ngrok tcp 6080

```

**Note:** point to `E:\viostor\w10\x86` virt io storage driver if installer give no hdd driver error.
## After Installation
Update Ethernet driver from virtio cdrom. Disable 4444 port in firewall to allow webdriver access for selenium. 


## Snapshot

```
qemu-img create -b hdd.img -f qcow2 snapshot.img
```

Boot snapshot:
```
qemu-system-x86_64 -enable-kvm \
        -machine q35 -smp sockets=1,cores=1,threads=2 -m 2048 \
        -usb -device usb-kbd -device usb-tablet -rtc base=localtime \
        -net nic,model=virtio -net user,hostfwd=tcp::4444-:4444 \
        -drive file=snapshot.img,media=disk,if=virtio \
        -monitor stdio
```

Build image:
```
mv hdd.img snapshot.img image
docker build -t windows/edge:18 . # For Microsoft Edge
docker run -it --rm --privileged -p 4444:4444 -p 5900:5900 windows/edge:18 # For Microsoft Edge
```


# Remove images
```
docker rm windows*
docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' | grep 'windows_vnc') -f
```