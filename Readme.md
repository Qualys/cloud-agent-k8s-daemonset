# cloud-agent-k8s-daemonset

Many customers want the ability to to boot strap K8S worker nodes with agents such as Qualys Cloud Agent. This script which is heavily inspired by [patnaikshekhar](https://github.com/patnaikshekhar/AKSNodeInstaller) lets you do that. The script is made available to all nodes via a config map and then in the container, install.sh is executed. This executes as a DaemonSet and is run on existing and new nodes. After the installation, the container will sleep infinity.

## Configuration

In ./k8s/sampleconfigmap.yaml

*Customize Agent Installer Location*

Set your own Qualys Cloud Agent source
```
AgentLocationDebian="https://qca-installer-binary-debian-URL"

AgentLocationRPM="https://qca-installer-binary-RPM-URL"

AgentLocationDebianArm="https://qca-installer-binary-debian-ARM-URL"

AgentLocationRPMArm="https://qca-installer-binary-RPM-ARM-URL"
```

*Customize deployment config from your Qualys Subscription*
```
ActivationID="QCA-ActivationId"

CustomerID="QCA-CustomerId"
```

Use the ServerUri value from https://www.qualys.com/platform-identification/ under Cloud Agent server with example format "https://qagpublic.qg1.apps.qualys.com/CloudAgent/"
```
ServerUri="https://<Qualys-Subscription-URL>/CloudAgent/"
```

*Set logging level*
```
LogLevel="5"
```

In ./k8s/daemonset.yaml

*Set image location

```
image: qualyssa/qca-k8s-bootstrap:latest
```

## Installation

Before installing update the script variables in k8s/sampleconfigmap.yaml .

```sh
git clone https://github.com/qualys/cloud-agent-k8s-bootstrap
cd cloud-agent-k8s-bootstrap
docker build .
docker tag imageID yourRegistry/repo:tag
docker push yourRegistry/repo:tag
# Update ./k8s/daemonset
# Update script variables in ./k8s/sampleconfigmap.yaml to use your Agent Installer Binary URLs, ActivationID, CustomerID, ServerURI, and image location
kubectl apply -f ./k8s
```

## Dockerfile
Dockerfile is included to make your own image for loading into your registry
