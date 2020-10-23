kernel_path=$(pwd)"/rootfs/vmlinux.bin"
#rootfs_path=$(pwd)"/rootfs/xenial.rootfs.ext4"
rootfs_path=$(pwd)"/rootfs/my/rootfs.ext4"
curl --unix-socket /tmp/firecracker.socket -i \
       -X PUT 'http://localhost/boot-source'   \
       -H 'Accept: application/json'           \
       -H 'Content-Type: application/json'     \
       -d "{
             \"kernel_image_path\": \"${kernel_path}\",
             \"boot_args\": \"keep_bootcon console=ttyS0 reboot=k panic=1 pci=off\"
        }"
 

curl --unix-socket /tmp/firecracker.socket -i \
   -X PUT 'http://localhost/drives/rootfs' \
   -H 'Accept: application/json'           \
   -H 'Content-Type: application/json'     \
   -d "{
         \"drive_id\": \"rootfs\",
         \"path_on_host\": \"${rootfs_path}\",
         \"is_root_device\": true,
         \"is_read_only\": false
    }"
 

curl --unix-socket /tmp/firecracker.socket \
 -X PUT 'http://localhost/network-interfaces/eth0' \
 -H 'accept:application/json' \
 -H 'Content-Type:application/json' \
 -d '{
 "iface_id": "eth0",
 "guest_mac": "AA:FC:00:00:00:AB",
 "host_dev_name": "ftap0"
 }'
curl --unix-socket /tmp/firecracker.socket -i \
   -X PUT 'http://localhost/actions'       \
   -H  'Accept: application/json'          \
   -H  'Content-Type: application/json'    \
   -d '{
       "action_type": "InstanceStart"
    }'

#iptables -t nat  -A POSTROUTING -s 10.10.104.83/32  -o enahisic2i0  -j MASQUERADE
