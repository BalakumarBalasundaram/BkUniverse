function Get-FolderSize {
 [CmdletBinding()]
 Param (
 [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
 $Path
 )
 if ( (Test-Path $Path) -and (Get-Item $Path).PSIsContainer ) {
 $Measure = Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
 $Sum = '{0:N2}' -f ($Measure.Sum / 1Gb)
 [PSCustomObject]@{
 "Path" = $Path
 "Size($Gb)" = $Sum
 }
 }
 }
 
 Get-FolderSize ('C:\Users\')
 
 
 
 C:\> $targetfolder='C:\'
 C:\> $dataColl = @()
 C:\> gci -force $targetfolder -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
 $len = 0
 gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
 $foldername = $_.fullname
 $foldersize= '{0:N2}' -f ($len / 1Gb)
 $dataObject = New-Object Object
 Add-Member -inputObject $dataObject -memberType NoteProperty -name “foldername” -value $foldername
 Add-Member -inputObject $dataObject -memberType NoteProperty -name “foldersizeGb” -value $foldersize
 $dataColl += $dataObject
 }
 C:\> $dataColl | Out-GridView -Title “Size of subdirectories”
