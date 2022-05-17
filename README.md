# kubetools

A PowerShell module with useful functions for Kubernetes cluster management.

## Installation

This module is hosted in [PowerShell Gallery](https://powershellgallery.com/packages/kubetools).
Use the built-in `Install-Module` command to install it to your non-admin directory.
If you're running as root (ie. inside a Docker container), you can remove the `-Scope` parameter.

```
Install-Module -Name kubetools -Scope CurrentUser -Force
```

## Functions

`Start-KubernetesPortForward` - initiates a port-forwarding tunnel to a Service, Deployment, Pod. Supports auto-completion.

## Aliases

|Name|Target
|-|-
|`kpf`|`Start-KubernetesPortForward`

## Limitations

This module assume that:

* Kubectl is installed
* You've set your `$env:KUBECONFIG` environment variable
* *OR* you're using the default `$HOME/.kube/config` file
* You've already set the active Kubernetes context
* You have full access to the Kubernetes API Server (untested with limited privileges)
