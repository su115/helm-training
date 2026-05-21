
# Create helm package
helm package nginx-chart --destination packages


# index.yaml
helm repo index packages --url https://su115.github.io/helm-training/packages


# Usage
helm repo add my-repo https://su115.github.io/helm-training/packages
helm repo update
