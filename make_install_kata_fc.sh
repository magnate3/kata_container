step1:
runtime/Makefile
DEFAULT_HYPERVISOR ?= $(HYPERVISOR_QEMU)
make && make install
step2:
/usr/share/defaults/kata-containers/configuration.toml
path = "/usr/bin/firecracker"
valid_hypervisor_paths = ["/usr/bin/firecracker"]
step3:
storage-driver=devicemapper
docker info | grep storage-driver
step4:
 /etc/systemd/system/docker.service.d/kata-containers.conf 
systemctl daemon-reload
step5:
5.1 firecracker --api-sock /tmp/firecracker.socket
5.2 : ctr images pull docker.io/library/nginx:alpine
5.3 : ctr run --runtime io.containerd.run.kata.v2 -t --rm docker.io/library/nginx:alpine sh
5.4 docker run --rm  --runtime=kata-runtime -itd --name=kata-test alpine sh 
    docker run --rm  --runtime=kata-runtime -itd --name=kata-test alpine sh
	docker exec -it kata-test sh
5.5: docker rm -f $(docker ps -aq)
step6:
 ctr run --runtime io.containerd.runc.v1  -t --rm docker.io/library/nginx:alpine sh
 ctr run --runtime io.containerd.runc.v2  -t --rm docker.io/library/nginx:alpine sh
		                                                                           
