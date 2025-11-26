CLUSTER ?= atlantis

edb:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml

usermonitoring:
	oc -n openshift-monitoring get configmap cluster-monitoring-config -o yaml | sed -r 's/(\senableUserWorkload:\s).*/\1true/' | oc apply -f -

devspaces:
	ansible-playbook ansible/playbook-configure-devspaces.yaml

gitlab:
	ansible-playbook -e cluster=$(CLUSTER) ansible/playbook-configure-gitlab.yaml

keycloak:
	ansible-playbook -e cluster=$(CLUSTER) ansible/playbook-configure-keycloak.yaml

rhdh:
	ansible-playbook -e cluster=$(CLUSTER) ansible/playbook-configure-rhdh.yaml

acs: 
	ansible-playbook ansible/playbook-configure-acs.yaml

all: edb usermonitoring devspaces gitlab keycloak rhdh acs

# Cluster-specific targets - configure all services for a specific cluster
atlantis:
	$(MAKE) edb
	$(MAKE) devspaces
	$(MAKE) gitlab CLUSTER=atlantis
	$(MAKE) keycloak CLUSTER=atlantis
	$(MAKE) rhdh CLUSTER=atlantis
	$(MAKE) acs

central:
	$(MAKE) edb
	$(MAKE) devspaces
	$(MAKE) gitlab CLUSTER=central
	$(MAKE) keycloak CLUSTER=central
	$(MAKE) rhdh CLUSTER=central
	$(MAKE) acs

gotham:
	$(MAKE) edb
	$(MAKE) devspaces
	$(MAKE) gitlab CLUSTER=gotham
	$(MAKE) keycloak CLUSTER=gotham
	$(MAKE) rhdh CLUSTER=gotham
	$(MAKE) acs

madripoor:
	$(MAKE) edb
	$(MAKE) devspaces
	$(MAKE) gitlab CLUSTER=madripoor
	$(MAKE) keycloak CLUSTER=madripoor
	$(MAKE) rhdh CLUSTER=madripoor
	$(MAKE) acs

metropolis:
	$(MAKE) edb
	$(MAKE) devspaces
	$(MAKE) gitlab CLUSTER=metropolis
	$(MAKE) keycloak CLUSTER=metropolis
	$(MAKE) rhdh CLUSTER=metropolis
	$(MAKE) acs

wakanda:
	$(MAKE) edb
	$(MAKE) devspaces
	$(MAKE) gitlab CLUSTER=wakanda
	$(MAKE) keycloak CLUSTER=wakanda
	$(MAKE) rhdh CLUSTER=wakanda
	$(MAKE) acs

# ArgoCD Application targets - create GitOps applications for each cluster
gitops-atlantis:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml
	oc apply -f manifests/argocd/acs-config-job.yaml
	oc apply -f manifests/argocd/devspaces-config-job.yaml
	oc apply -f manifests/argocd/gitlab-config-job-atlantis.yaml
	oc apply -f manifests/argocd/keycloak-config-job-atlantis.yaml
	oc apply -f manifests/argocd/rhdh-config-job-atlantis.yaml

gitops-central:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml
	oc apply -f manifests/argocd/acs-config-job.yaml
	oc apply -f manifests/argocd/devspaces-config-job.yaml
	oc apply -f manifests/argocd/gitlab-config-job-central.yaml
	oc apply -f manifests/argocd/keycloak-config-job-central.yaml
	oc apply -f manifests/argocd/rhdh-config-job-central.yaml

gitops-gotham:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml
	oc apply -f manifests/argocd/acs-config-job.yaml
	oc apply -f manifests/argocd/devspaces-config-job.yaml
	oc apply -f manifests/argocd/gitlab-config-job-gotham.yaml
	oc apply -f manifests/argocd/keycloak-config-job-gotham.yaml
	oc apply -f manifests/argocd/rhdh-config-job-gotham.yaml

gitops-madripoor:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml
	oc apply -f manifests/argocd/acs-config-job.yaml
	oc apply -f manifests/argocd/devspaces-config-job.yaml
	oc apply -f manifests/argocd/gitlab-config-job-madripoor.yaml
	oc apply -f manifests/argocd/keycloak-config-job-madripoor.yaml
	oc apply -f manifests/argocd/rhdh-config-job-madripoor.yaml

gitops-metropolis:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml
	oc apply -f manifests/argocd/acs-config-job.yaml
	oc apply -f manifests/argocd/devspaces-config-job.yaml
	oc apply -f manifests/argocd/gitlab-config-job-metropolis.yaml
	oc apply -f manifests/argocd/keycloak-config-job-metropolis.yaml
	oc apply -f manifests/argocd/rhdh-config-job-metropolis.yaml

gitops-wakanda:
	oc apply -f manifests/argocd/edb.yaml
	oc apply -f manifests/argocd/edb-workshop-prod.yaml
	oc apply -f manifests/argocd/acs-config-job.yaml
	oc apply -f manifests/argocd/devspaces-config-job.yaml
	oc apply -f manifests/argocd/gitlab-config-job-wakanda.yaml
	oc apply -f manifests/argocd/keycloak-config-job-wakanda.yaml
	oc apply -f manifests/argocd/rhdh-config-job-wakanda.yaml
