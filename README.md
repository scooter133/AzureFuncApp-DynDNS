# AzureFuncApp-DynDNS
Azure Function App to Mimic DynDNS Server to update Azure Zone records

## Creating and setting up the Function App Resouce

### Create your Function App Resource
From your *Function App* Blade, Click **+Create**
 
#### Function App Basics
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

#### Function App Storage
*Storage Account* You can Select an Existing storage account from the list, or you can use the default **(New) AzDynDNS<id>** storage account

*Blob service diagnostic settings* select **Don't Configure diagnostic settings now**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/f8335d5a-a647-49ee-b09e-6d2b287f448a)

#### Function App Networking
*Enable public access* if using from outside a private connection, select **on**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/253ec3a6-19d8-4f20-8cc9-e57bb2d7681e)

#### Function App Monitoring
*Enable Application Insights* can be left at **No**
If you would like to have debugging or application insights, you will need to select **Yes**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/5cab847d-027f-4477-aca3-0dc3fa3debfd)

#### Function App Deployment
*Basic authentication* select **Disable**
*Continuous deployment* select **Disable**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/47d53a66-5057-46a8-825d-804acf427392)

#### Function App Tags
Add any tags that you would like to associate with this *Function App* Resource
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/1627e624-c471-4234-b5ef-440c15c58c12)

#### Function App Review + create
Review your settings and click **Review + Create**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/da885484-2a69-40ba-95bf-c1f19aff349f)


### Function App Configuration
Go to your newly created *Function App* resource, Click **Configuration** to open the *Configuration* blade

![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/fc587cbd-fbe2-40dc-8dc4-3daa76d12871)

#### Function App Configuration | Application Settings
Select **+ New Application setting**

#### Function App Configuration | Application Settings | Add/Edit applicatiomn setting
This is where we will define the user's password or APIKey that the DynDNS Client will use to Authenticate with the Function App Code
For the *Name* enter: **APIKey**
For the *Value* enter a string that you will use as your Password/APIKey
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/a480bbb5-b2d7-4902-91a3-e6c3df8a94dc)

Save your Application Settings
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/907a0841-4989-400d-bad8-1fd7c2919a47)

### Enable the Az PowerShell Module
Under the *Functions* section, select **App files**
Under the files drop-down select **requirements.psd1**
Uncomment the line 'Az' = '11.*'
Click **Save**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/6eee59a1-9b5f-4cec-8ea1-22d4bf0a1ddd)

### Enable the Function App Managed Identity
We need to enable the *Function App*'s Managed Identity so we can assign it a DNS Contributor Role.
From the *Function App*'s blade, select **Identity**
Under *System assigned*, *Status* select **On**
Click **Save** to save the setting
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/5efdc492-5e1b-4fcd-8a38-8e38e046cdc9)

## Creating and setting up the Function App Function
### Creating the Function App Function
From the *Function App*'s blade, select **Overview**
From the *Functions* Section, select **Create Function**
From the *Function App*'s blade, select **Identity**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/07322878-e488-48cd-9d74-7af25d90ba01)

### Create Function
For this function we can use the *Development environment* of **Develop in portal**
Under the *Select a template* use the **HTTP trigger** Template
Under *Template Details*
   *New Function*: name the Function within the Function App
   *Authorization level* for added security select **Function**
click **Create**
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/b08f61e0-98c3-4b33-96c1-ad09fb4299e3)

### Function | Integfration

![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/96842acc-9dec-42e4-a5f7-93bf65def3ad)


#### Function | Integfration | Edit Trigger

![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/b0f5e34a-fdad-4b07-82f1-213ee0fd0c77)


### Function | Code + Test
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/f5ecdfb5-fb41-4f44-8d46-b782a3a85305)


## Settig up the Security
to allow the Function App to have permissions to the DNS Records, we need to give it DNS Contribute Role for the Resource Group or the Zone. 

### Access Security - Resouce Group | IAM
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/29617805-bc08-47a6-b8e7-7b93fa29b9ed)

### Access Security - Zone | IAM
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/62a7568f-fae7-424d-85c4-0d7cc6e2f22a)

### Add Role Assignment | Role
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/87e46b13-ba82-41f7-963e-92989b20ecdd)

### Add Role Assignment | Members
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/a6333dac-cf73-4dab-8538-dc1c441b5f2a)

### Add Role Assignment | Select Managed identities
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/ab766e2c-fcf0-4a43-a1b1-436fa2d133de)

### Add Role Assignment | Review + assign
![image](https://github.com/scooter133/AzureFuncApp-DynDNS/assets/284919/4664614c-30b5-4f76-a3fc-eeb5bd162a84)





