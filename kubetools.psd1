@{
  RootModule = 'kubetools.psm1'
  Author = 'Trevor Sullivan <trevor@trevorsullivan.net>'
  CompanyName = 'Trevor Sullivan'
  ModuleVersion = '0.1'
  GUID = '0f5ef264-e8d2-4483-9d7a-e3cc978b621a'
  Copyright = '2022 Trevor Sullivan'
  Description = 'A PowerShell module with useful functions for Kubernetes cluster management.'
  PowerShellVersion = '6.0'
  CompatiblePSEditions = @('Core')
  FunctionsToExport = @('Start-KubernetesPortForwarding')
  AliasesToExport = @('kpf')
  VariablesToExport = @('')
  PrivateData = @{
    PSData = @{
      Tags = @('kubernetes', 'cloud', 'devops', 'automation', 'cluster')
      LicenseUri = ''
      ProjectUri = 'https://github.com/pcgeek86/kubetools'
      IconUri = ''
      ReleaseNotes = @'
0.1 - Initial release with "kpf" command to perform port-forward with ease
'@
    }
  }
}
