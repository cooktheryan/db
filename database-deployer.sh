kubectl create -f ../db
kubectl create secret generic pull-sec -n mysql --from-file=.dockerconfigjson=/home/`whoami`/.docker/config.json --type=kubernetes.io/dockerconfigjson
kubectl expose svc trillian-mysql --port=3306 --name trillian-mysql-route