[CmdletBinding()]
Param(
    [string]$ImageName,
	[string]$DockerFilePath
)

if (-Not $ImageName) {
    Write-Host -ForegroundColor Red "Please specify image name with version e.g. my-image:v1"
    Write-Host -ForegroundColor Cyan ""
    exit -1
}

if (-Not $DockerFilePath) {
    Write-Host -ForegroundColor Red "Please specify docker file directory path"
    Write-Host -ForegroundColor Cyan ""
    exit -1
}

$UserName = "<<username>>"
$Password = "<<password>>"
$SubscriptionId = "<<subscription_id>>"
$ResourceGroupName = "DigitalOnline"
$AcrName = "UploadDocument"
$Location = "southindia"
$Sku = "Standard"

Function Azure-Login {
	Write-Host -ForegroundColor Green "Azure login..."
    az login -u $UserName -p $Password
	az account set -s $Subscriptionid
	Write-Host -ForegroundColor Green "login success"
}

Function ResourceGroup-Create {	
	if ((az group exists -n $ResourceGroupName) -eq "true")
	{
		Write-Host -ForegroundColor Yellow "Resource group"$ResourceGroupName" is exist"
	}
	else
	{
		Write-Host -ForegroundColor Green "Creating resource group..."
		az group create -l $Location -n $ResourceGroupName
	}
}

Function Acr-Create {
	Write-Host -ForegroundColor Green "Creating container registry..."
	az acr create -n $AcrName -g $ResourceGroupName --sku $Sku
}

Function Image-Build {
	Write-Host -ForegroundColor Green "Build & push image in container registry"
    az acr login -n $AcrName.ToLower()
	$TagName = $AcrName.ToLower() + ".azurecr.io/" + $ImageName
	docker build -t $ImageName $DockerFilePath
	docker tag $ImageName $TagName
	docker push $TagName
}

Function Azure-Logout {
	Write-Host -ForegroundColor Green "Log off"
    az logout --username $UserName
}

Azure-Login
ResourceGroup-Create
Acr-Create
Image-Build
Azure-Logout