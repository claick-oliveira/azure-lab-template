@sys.description('The Public IP Address name')
param publicIpName string

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

@allowed([
  'Static'
  'Dynamic'
])
param publicIpMethod string

// Create the public IP address
resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: publicIpMethod
  }
  tags: {
    environment: 'lab'
  }
}

// Output the public IP address
output publicIPAddressId string = publicIPAddress.id
output publicIPAddressName string = publicIPAddress.name
output publicIPAddressLocation string = publicIPAddress.location
output publicIPAddressSku string = publicIPAddress.sku.name
output publicIPAddressMethod string = publicIPAddress.properties.publicIPAllocationMethod
