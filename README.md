Audit Assistant Helm charts repository
======================================

This repository contains the Fortify Audit Assistant Helm charts. It features a directory for each
Audit Assistant release (for example `19.2.0`). The release directory contains Helm chart packages
for the release and an example of chart configuration file named `custom-values-example.yaml`.

A Helm chart package can be downloaded and used locally as follows:

```sh
# deploy Audit Assistant version 1.0.0 from a local chart package
helm install ./audit-assistant-1.0.0+19.2.0.0050.tgz ...
```

Additionally, valid metadata for a Helm chart repository are included allowing use with Helm as follows:

```sh
# add remote Helm chart repository named "fortify"
helm repo add fortify https://raw.githubusercontent.com/fortify/audit-assistant-helm-charts/repo/
# list all chart versions in "fortify" repository
helm search fortify/
# deploy Audit Assistant chart version 1.0.0 from a remote chart package
helm install fortify/audit-assistant --version 1.0.0 ...
```

Please refer to Audit Assistant documentation for full instructions.
