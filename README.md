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

## Usage

### Initiate Port Forwarding

You can use the `Start-KubernetesPortForward` command, or its `kpf` alias, to initiate a port forwarding operation.
The `-Target` parameter is assumed to be the first positional parameter, so you don't need to type the literal `-Target` after the command.
You can tab-complete the name of any Service, Deployment, or Pod resource across the entire cluster.

```powershell
kpf <tab>
```

You can also use a regular expression to find a specific resource, based on its name.
For example, the following command will return any results that 

```powershell
kpf ui$<tab>
```

When you auto-complete a resource name, it will automatically expand to include the namespace of the resource, as well as the resource type, and the target port.
A random source port will be selected, between 25000-30000. This may change in the future.

The above command will automatically expand into something similar to the following:

```powershell
kpf Deployment/longhorn-ui -Namespace longhorn-system -Port 8000
```

## Limitations

This module assume that:

* Kubectl is installed
* You've set your `$env:KUBECONFIG` environment variable
* *OR* you're using the default `$HOME/.kube/config` file
* You've already set the active Kubernetes context
* You have full access to the Kubernetes API Server (untested with limited privileges)
