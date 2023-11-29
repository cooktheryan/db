kubectl create -f ../db
kubectl create secret generic pull-sec -n mysql --from-file=.dockerconfigjson=/home/`whoami`/.docker/config.json --type=kubernetes.io/dockerconfigjson
