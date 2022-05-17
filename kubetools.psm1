function Start-KubernetesPortForward {
  <#
  .SYNOPSIS
  Initiates port-forwarding to a Kubernetes Pod, Service, Deployment, etc.
  #>
  [CmdletBinding()]
  param (
    [Parameter(Position = 0)]
    [string] $Target,
    [string] $Namespace,
    [int] $Port
  )
  $RandomPort = Get-Random -Minimum 25000 -Maximum 35000
  kubectl port-forward $Target --namespace $Namespace $RandomPort`:$Port
}

function Get-KubernetesPortForwardingResources {
  <#
  .SYNOPSIS
  Helper function for Intellisense. Retrieves Kubernetes resources and returns them to the argument completer function.
  #>
  [CmdletBinding()]
  param (
  )
  $ObjectList = @()
  $ObjectList = (kubectl get service --all-namespaces --output=json | ConvertFrom-Json).items
  $ObjectList += (kubectl get deployment --all-namespaces --output=json | ConvertFrom-Json).items
  $ObjectList += (kubectl get pod --all-namespaces --output=json | ConvertFrom-Json).items
  return $ObjectList
}

function Get-KubernetesPortFromResource {
  <#
  .Synopsis
  Given an input Kubernetes resource, as an object, this function attempts to determine the port that someone wants to port-forward to.
  #>
  [CmdletBinding()]
  param (
    [object] $Resource
  )
  switch ($Resource.kind) {
    'Service' {
      return $Resource.spec.ports[0].port
      break;
    }
    'Deployment' {
      return $Resource.spec.template.spec.containers[0].ports[0].containerPort
    }
    'Pod' {
      return $Resource.spec.containers[0].ports[0].containerPort
    }
  }
}

Register-ArgumentCompleter -CommandName Start-KubernetesPortForward -ParameterName Target -ScriptBlock {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
  $CursorPosition = $Host.UI.RawUI.CursorPosition
  Write-Host -Object 'Loading ...' -ForegroundColor Green -NoNewLine
  Get-KubernetesPortForwardingResources | 
    Where-Object -FilterScript { $PSItem.metadata.name -match $wordToComplete } |
    ForEach-Object -Process {
      $PortNumber = Get-KubernetesPortFromResource -Resource $PSItem
      '{0}/{1} -Namespace {2} -Port {3}' -f $PSItem.kind, $PSItem.metadata.name, $PSItem.metadata.namespace, $PortNumber;
    }
  $Host.UI.RawUI.CursorPosition = $CursorPosition
  Write-Host -Object (' '*11) -NoNewline
}

New-Alias -Name kpf -Value Start-KubernetesPortForward -Description 'Initiates Kubernetes port forwarding against a Pod, Deployment, Service, etc.'
