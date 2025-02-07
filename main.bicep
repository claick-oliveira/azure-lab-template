targetScope='subscription'

var resourceGroupName = 'myLab'

@allowed([
  'eastus'
  'eastus2'
  'centralus'
  'westus'
  'westus2'
  'brazilsouth'
  'brazilsoutheast'
])
@sys.description('The location of Lab deployment')
param location string

// Create a resource group
module resourceGroupLab 'modules/resourcegroup.bicep' = {
  name: resourceGroupName
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
}

// Create the hub and spoke networks
module hubNetwork 'modules/vnet.bicep' = {
  name: 'hubNetwork'
  scope: resourceGroup(resourceGroupLab.name)
  params: {
    hubNetworkName: 'hubNetwork'
    location: location
    hubNetworkSpacePrefix: '10.0.0.0/16'
    subnet1Name: 'bastion-subnet'
    subnet1Prefix: '10.0.10.0/24'
    subnet2Name: 'firewall-subnet'
    subnet2Prefix: '10.0.20.0/24'
  }
}

module spokeNetwork 'modules/vnet.bicep' = {
  name: 'spokeNetwork'
  scope: resourceGroup(resourceGroupLab.name)
  params: {
    hubNetworkName: 'spokeNetwork'
    location: location
    hubNetworkSpacePrefix: '10.10.0.0/16'
    subnet1Name: 'app-subnet'
    subnet1Prefix: '10.10.10.0/24'
    subnet2Name: 'database-subnet'
    subnet2Prefix: '10.10.20.0/24'
  }
}

// Create the peering between the hub and spoke networks
module hubToSpokePeering 'modules/peering.bicep' = {
  name: 'hubSpokePeering'
  scope: resourceGroup(resourceGroupLab.name)
  params: {
    sourceNetworkname: hubNetwork.outputs.vNetworkName
    vNetPeeringName: 'hub-spoke'
    vNetDestinationId: spokeNetwork.outputs.vNetworkID
  }
}

module spokeToHubPeering 'modules/peering.bicep' = {
  name: 'spokeHubPeering'
  scope: resourceGroup(resourceGroupLab.name)
  params: {
    sourceNetworkname: spokeNetwork.outputs.vNetworkName
    vNetPeeringName: 'spoke-hub'
    vNetDestinationId: hubNetwork.outputs.vNetworkID
  }
}

@allowed([
  true
  false
])
@sys.description('Deploy the storage account, true or false')
param deployStorageAccount bool

// Create the storage account
module storageAccount 'modules/storageaccount.bicep' = if (deployStorageAccount) {
  name: 'storageAccount'
  scope: resourceGroup(resourceGroupLab.name)
  params: {
    storageAccountName: 'labsa${uniqueString(resourceGroupLab.outputs.resourceGroupID)}'
    location: location
    storageAccountSKU: 'Standard_LRS'
    storageAccountKind: 'StorageV2'
    storageAccountTier: 'Hot'
  }
}
