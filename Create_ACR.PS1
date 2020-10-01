 
1. install azure CLI version 
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

2. Run Powershell

3. Login in Azure
 > az login -u <<username>> -p <<password>>
 
4. Creare ACR
	az acr create -n UploadDocuments2 -g DigitalOnline --sku Standard 
 
4. make sure Docker Deamon is Runing

5. login Container registry
az acr login -n <<container registry>>
 
