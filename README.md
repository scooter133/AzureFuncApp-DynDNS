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
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/5cab847d-027f-4477-aca3-0dc3fa3debfd)

### Function App Deployment
*Basic authentication* select **Disable**
*Continuous deployment* select **Disable**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/47d53a66-5057-46a8-825d-804acf427392)

### Function App Tags
Add any tags that you would like to associate with this *Function App* Resource
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/1627e624-c471-4234-b5ef-440c15c58c12)


### Function App Review + create
Review your settings and click **Review + Create**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/da885484-2a69-40ba-95bf-c1f19aff349f)



## Function App Configuration
Go to your newly created *Function App* resource, Click **Configuration** to open the *Configuration* blade![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/18ab4300-3d41-405c-a26a-7bbb3cfb17a3)

