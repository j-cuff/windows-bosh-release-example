Set-PSDebug -trace 1            # "set -x"
Set-PSDebug -strict             # "set -u"
$ErrorActionPreference = "Stop" # "set -e"

# avoid overly narrow default linewrap
$term = (get-host).ui.rawui
$size = $term.buffersize
$size.width = 128
$term.buffersize = $size
$size = $term.windowsize
$size.width = 128
$term.windowsize = $size

Start-Process msiexec.exe -Wait -ArgumentList '/I NessusAgent-10.3.1-x64.msi /quiet'

#Start-Process -FilePath C:\var\vcap\packages\qualys-windows-binary\qualys-windows-binary\QualysCloudAgent.exe -ArgumentList "CustomerId={guid}","ActivationId={guid}" 
