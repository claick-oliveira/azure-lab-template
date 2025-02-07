targetScope = 'subscription'

@sys.description('The resource group name')
param resourceGroupName string

@allowed([
  'eastus'
  'eastus2'
  'centralus'
  'westus'
  'westus2'
  'brazilsouth'
  'brazilsoutheast'
])
param location string

// Create a resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    environment: 'lab'
  }
}

// Output the resource group
output resourceGroupID string = resourceGroup.id
output resourceGroupName string = resourceGroup.name
output resourceGroupLocation string = resourceGroup.location
