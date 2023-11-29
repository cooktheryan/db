oc apply -f 00-namespace.yaml
oc project mysql
oc apply -f 01-pvc.yaml
yq 'del(.imagePullSecrets)' 01-sa.yaml > 01-openshift-sa.yaml 
oc apply -f 01-openshift-sa.yaml
oc apply -f 01-secret.yaml
oc apply -f 02-service.yaml
yq '.spec.template.spec.containers.0 += {"securityContext": {"allowPrivilegeEscalation": false, "seccompProfile": {"type": "RuntimeDefault"}, "capabilities": {"drop": ["ALL"]}}}' 02-deployment.yaml > 02-openshift-deployment.yaml
oc apply -f 02-openshift-deployment.yaml
oc create secret generic pull-sec -n mysql --from-file=.dockerconfigjson=/home/`whoami`/.docker/config.json --type=kubernetes.io/dockerconfigjson
oc expose svc trillian-mysql -n mysql --port=3306 --name trillian-mysql-route