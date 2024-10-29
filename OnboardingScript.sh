# Add the service principal application ID and secret here
ServicePrincipalId="<ServicePrincipalId>";
ServicePrincipalClientSecret="<ENTER SECRET HERE>";


export subscriptionId="6e1b07e5-8504-481d-ba73-20f427f4a278";
export resourceGroup="RG-ARC-DEMO";
export tenantId="16b3c013-d300-468d-ac64-7eda0820b6d3";
export location="eastus2";
export authType="principal";
export correlationId="a349c662-fb52-4e85-9c11-db714491b856";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://gbl.his.arc.azure.com/azcmagent-linux -O /tmp/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash /tmp/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$ServicePrincipalId" --service-principal-secret "$ServicePrincipalClientSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
