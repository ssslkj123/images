#!/bin/bash

#NAMESPACE="$1"
#namespace=${NAMESPACE:-"default"}

#echo $namespace
#!/bin/bash

NS="$1"
namespace=${NS:-"test33"}
ND="$2"
node=${ND:-"ack-test-172.31.192.38"}

echo $namespace
echo $node
token=`kubectl --kubeconfig=/root/.kube/caocao-ack-test.kubeconfig get secret -n kube-system  -o json  admin-token |jq -r '(.data.token)' |base64 -d`
echo $token

curl -s -k -H "Authorization: Bearer $token" https://114.55.29.34:6443/api/v1/pods |jq -r '(.items[]|select(.metadata.namespace=="'$namespace'")|select(.spec.nodeName=="'$node'")|"Podname: " + .metadata.name +  "  #  " + "ContainerID: " + .status.containerStatuses[].containerID + "  #  " + .metadata.uid )'  | column -t
