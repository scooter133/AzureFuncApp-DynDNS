using namespace System.Net
param($Request, $TriggerMetadata)

##############
# Debug Flag to write debug messages to host console
$Debug = $true
#Set a Default Azure Resource Group for the DNS Zone you will be updating
$ResourceGroup = "Your Defaut Azure Resource Group"
##############
# We are using Basic Authenticatio and the API Key is in the Password Field so we need to be sure there is an Authentication Header 
if (!$request.headers.authorization) {
    #
    if ($Debug) {
        write-host "No API key"
    }
    # Set our HTTP Response 
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = "401 - No API token"
        })
    # Nothing else to do, lets Exit
    exit
}

# Authentication/APIKey processing
# we are using the password from the Basic Authentication header as our API Key to verify that the user is valid. 
# Grab the Request Authentication Header and store it 
$AuthHeader = $request.headers.authorization
# Authentication header is in form 'Basic Base64encodedUser:Pass' Grab just the Base64Encoded username:password
$Base64APIKey = $AuthHeader -split " " | select-object -last 1
# the API Key is the unencoded password portion of the username:password. decode the username:password and grab the passeword portion
$APIKey = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($Base64APIKey)) -split ":" | select-object -last 1

# Check the APIKey Password that was entered against the Funcation App's Configuration of the APIKey
if ($APIKey -ne $env:APIKey) {
    # The Key entered is not the samer as the Function App's APIKey Configuration Variable. 
    if ($Debug) {
        write-host "Invalid API key"
        write-host "AuthString: $AuthHeader"
        write-host "Base64APIKey: $Base64APIKey"
        write-host "APIKey: $APIKey"
    }
    # Set our HTTP Response 
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body = "401 - API token is invalid."
    })
    # Nothing left with no valif Key, lets bail out
    exit
}

# We are Expecting a FQDN from the HTTP GET in the 'hostname' request variable
# hosatname.zonename  Where hostname does not have a '.' in it. 
# Hostname is the portion before the first '.'
$hostname = $request.Query.hostname.Split('.')[0]
# ZoneName is the portion after $hostname.
$ZoneName = $request.Query.hostname -replace "$hostname.",""

# Lets see if we can get the Azure ResourceGroup of the $ZoneName
$AutoDetect = (get-azresource -ResourceType "Microsoft.Network/dnszones" -name $ZoneName )
# If we got a record, assign our $ResourceGroup the ResourceGroupName
If ($AutoDetect) {
    if ($Debug) {
        write-host "Using Autodetect For ResourceGroupName."
    }
    # Overwrite our $ResourceGroup with the one we got back
    $ResourceGroup = $AutoDetect.ResourceGroupName
}  
if ($Debug) {
    write-host "Hostname (FQDN): $request.Query.hostname"
    write-host "Hostname (Host): $hostname"
    write-host "Zone Name (Domain Part): $ZoneName"
    write-host "Zone's Azure Resource Group: $ResourceGroup"
}

# Grab the New IP from the Request
$NewIP = $request.Query.myip
if ($Debug) {
    write-host "$hostname in zone $ZoneName has $newip. Checking record and creating if required."
}
# Lets see if that Host record exists in our $ZoneName
$ExistingRecord = Get-AzDnsRecordSet -ResourceGroupName $ResourceGroup -ZoneName $ZoneName -Name $hostname -RecordType A -ErrorAction SilentlyContinue

# If we didnt get a record back, we need to create a new host rexord in the $ZoneName
if (!$ExistingRecord) {
    if ($Debug) {
        write-host "Creating new record for $Hostname"
    }
    # Add our new DNS Host Record
    New-AzDnsRecordSet -name $Hostname -Zonename $ZoneName -ResourceGroupName $ResourceGroup -RecordType A -Ttl 60 -DnsRecords (New-AzDnsRecordConfig -Ipv4Address $NewIP)
    # Set our HTTP Response
    Push-OutputBinding -Name Response -Value (  [HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = "good $newip"
        })
    #We are done, so we can Exit
    exit
} else {
    # We gor a AzdnsRecordSet back, see if the IP is the same or not
    if ($ExistingRecord.Records[-1].Ipv4Address -ne $NewIP) {
        # The Existing IP does not equal the new IP, we will update the record
        if ($Debug) {
            write-host "Updating record for $hostname in zonre $ZoneName - new IP is $newIP"
        }
        # Update the IP Address in the Record returned
        $ExistingRecord.Records[-1].Ipv4Address = $NewIP
        # Post back the record with the new IP Address

        Set-AzDnsRecordSet -RecordSet $ExistingRecord
        # Set our HTTP Response
        Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body = "good $newip"
        })
    } else {
        # Old IP of the record is the same as the IP we got, No update of Record needced. 
        if ($Debug) {
            write-host "No Change - $Hostname in zone $ZoneName IP is still $newIP"
        }
        # Set our HTTP Response
        Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body = "nochg $NewIP"
        })
    }
    #We are done updating, we can exit
    exit
}
