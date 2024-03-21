# AzureFuncApp-DynDNS
Azure Function App to Mimic DynDNS Server to update Azure Zone records

## Create your Function App Resource
From your *Function App* Blade, Click **+Create**
 
### Function App Basics
In the*Create Function App* Blade
Select your *subscription*
Select a *Resource Group* from the list, or click **Create new** to Create a new one
Enter a *Function app name* for your function. This needs to be unique name.
*Runtime stack* select **PowerShell Core**
*Version* Select **7.2** (or higher)
Select the *Region* for your Function App
*Operating System* select **Windows**
*Hosting Options and Plans* select **Consumption (serverless)**

![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/57542d08-cdf0-4630-abb3-8b064c604005)


### Function App Storage
*Storage Account* You can Select an Existing storage account from the list, or you can use the default **(New) AzDynDNS<id>** storage account

*Blob service diagnostic settings* select **Don't Configure diagnostic settings now**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/f8335d5a-a647-49ee-b09e-6d2b287f448a)


### Function App Networking
*Enable public access* if using from outside a private connection, select **on**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/253ec3a6-19d8-4f20-8cc9-e57bb2d7681e)


### Function App Monitoring
*Enable Application Insights* can be left at **No**
If you would like to have debugging or application insights, you will need to select **Yes**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/f939e8e9-368c-49af-9982-a9c1c815919c)


### Function App Deployment
*Basic authentication* select **Disable**
*Continuous deployment* select **Disable**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/d71c6bdc-9ae6-4894-9353-680e0484b9ec)
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/e29aa76b-e164-4129-becd-174d2eac8c1b)



### Function App Tags
Add any tags that you would like to associate with this *Function App* Resource
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/5e104012-1c91-45b0-aa4e-c8864974bfca)


### Function App Review + create
Review your settings and click **Review + Create**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/d019a709-f18e-4ace-b4e3-d7ed34257f5b)


## Function App Configuration
