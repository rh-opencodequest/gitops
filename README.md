# GitOps approach to deploy the OpenCodeQuest


## Fast Config

- Provision the "Red Hat Trusted Application Pipeline" demo environment on demo.redhat.com
- Login to OpenShift using `oc login ...`
- update RHDH to 1.8 in the demo (change the parameters in the argocd application) => this will be set by ansible soon as well
- Configure cluster for OpenCodeQuest : `make gitops-<cluster name>` 
This will setup OpenCodeQuest for the named cluster with a set of users (see files in ansible/rhdh_users/).





## Old Documentation

- [Cluster Deployment](documentation/CLUSTER_DEPLOYMENT.md)
- [Managed Cluster Configuration](documentation/MANAGED_CLUSTER_CONFIGURATION.md)
- [OpenShift AI Cluster Configuration](documentation/AI_CLUSTER_CONFIGURATION.md)
- [ACM Configuration](documentation/CENTRAL_CLUSTER_CONFIGURATION.md)

## Owners

- Sébastien Lallemand
- Nicolas Massé
