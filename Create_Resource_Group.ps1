 
1. install azure CLI version 
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

2. Run Powershell

3. Login in Azure
 > az login
 
4. Note subscription Id for default subscription
az account list --output table
 
5. 
az account set -s  "your subscription id"
 
6. Create Resource Group
 > az group create -l <<locatioin name " az account list-locations">> -n <<Resource group name>>
 


