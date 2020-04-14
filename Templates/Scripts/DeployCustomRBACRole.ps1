
#Get Azure context
$currentAzContext = Get-AzContext
$rgName = "20200414-aa-packervmbuild-rg"
$location = "South Central US"
$subscriptionID = $currentAzContext.Subscription.Id
$imageResourceGroup = $rgName

$RGStatus = Get-AzResourceGroup -Name "myrgtest" -ErrorAction SilentlyContinue

#if (!(Get-AzResourceGroup -Name $rgName -ErrorAction SilentlyContinue)) { write-host "is null..." }else{ write-host "found ResGrp!" }

$aibRoleImageCreationUrl="https://raw.githubusercontent.com/aatkins79/azureimagebuilder/master/Templates/RBAC_Custom_Roles/ImageBuilderCustomRole_ResGrpScope.json"
$aibRoleImageCreationPath = "c:\rbac\aibRoleImageCreation.json"

Invoke-WebRequest -Uri $aibRoleImageCreationUrl -OutFile $aibRoleImageCreationPath -UseBasicParsing

((Get-Content -path $aibRoleImageCreationPath -Raw) -replace '<subscriptionID>',$subscriptionID) | Set-Content -Path $aibRoleImageCreationPath
((Get-Content -path $aibRoleImageCreationPath -Raw) -replace '<rgName>', $imageResourceGroup) | Set-Content -Path $aibRoleImageCreationPath
