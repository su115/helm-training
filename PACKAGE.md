```sh
# Create helm package
helm package nginx-chart --destination packages


# index.yaml
helm repo index packages --url https://su115.github.io/helm-training/packages


# Usage
helm repo add my-repo https://su115.github.io/helm-training/packages
helm repo update

# Search
helm search repo myapp
# NAME         	CHART VERSION	APP VERSION	DESCRIPTION
# my-repo/myapp	0.1.0        	1.0.0      	Helm chart 


# Install
helm install nginx-release my-repo/myapp
```
