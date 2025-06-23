edb:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml

usermonitoring:
	oc -n openshift-monitoring get configmap cluster-monitoring-config -o yaml | sed -r 's/(\senableUserWorkload:\s).*/\1true/' | oc apply -f -

devspaces:
	ansible-playbook ansible/playbook-configure-devspaces.yaml

gitlab:
	ansible-playbook ansible/playbook-configure-gitlab.yaml

acs: 
	oc patch Central stackrox-central-services --patch '{"spec":{"scannerV4":{"scannerComponent": "Enabled"}}}' -n stackrox --type merge
	oc patch SecuredCluster stackrox-secured-cluster-services --patch '{"spec":{"scannerV4":{"scannerComponent": "AutoSense"}}}' -n stackrox --type merge
	ansible-playbook ansible/playbook-configure-acs.yaml

all: edb usermonitoring devspaces gitlab acs
