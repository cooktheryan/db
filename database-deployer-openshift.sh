
yq '.spec.template.spec.containers.0 += {"securityContext": {"allowPrivilegeEscalation": false, "capabilities": {"drop": ["ALL"]}}}' 02-deployment.yaml > 02-deployment.yaml
oc apply -f --kustomize ./
oc create secret generic pull-sec -n mysql --from-file=.dockerconfigjson=/home/`whoami`/.docker/config.json --type=kubernetes.io/dockerconfigjson
oc expose svc trillian-mysql --port=3306 --name trillian-mysql-route