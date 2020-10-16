# kubeadm config images list --kubernetes-version=v1.18.1
#ctr image pull --platform linux/arm/v5 docker.io/library/busybox:latest
#ctr -n k8s.io pull gcr.io/google_containers/etcd-arm64@sha256
images=(
k8s.gcr.io/kube-apiserver:v1.18.1
k8s.gcr.io/kube-controller-manager:v1.18.1
k8s.gcr.io/kube-scheduler:v1.18.1
k8s.gcr.io/kube-proxy:v1.18.1
k8s.gcr.io/pause:3.2
k8s.gcr.io/etcd:3.4.3-0
k8s.gcr.io/coredns:1.6.7
)

images2=(
kube-apiserver
kube-controller-manager
kube-scheduler
kube-proxy
pause
etcd
coredns
)
#ctr -n  k8s.io image rm $(ctr -n  k8s.io image list -q)
#ctr image rm $(ctr image list -q)
#for imageName in ${images2[@]};do
for(( i=0;i<${#images2[@]};i++)) do
    #echo k8s.gcr.io/${images2[i]};
    #echo ${images2[i]}.tar;
    #docker save -o ${images2[i]}.tar k8s.gcr.io/${images2[i]}
    docker save -o ${images2[i]}.tar ${images[i]}
    #ctr image import ${images2[i]}.tar --all-platforms
    #ctr image import ${images2[i]}.tar
    #ctr image import --no-unpack ${images2[i]}.tar
    ctr -n  k8s.io image import ${images2[i]}.tar  --all-platforms
done
