@sys.description('The HUB vNet name')
param hubNetworkName string

@allowed([
  'eastus'
  'eastus2'
  'centralus'
  'westus'
  'westus2'
  'brazilsouth'
  'brazilsoutheast'
])
@sys.description('The location of the HUB vNet')
param location string

@sys.description('The HUB vNet address space prefix, example 10.0.0.0/16')
param hubNetworkSpacePrefix string

@sys.description('The subnet1 name, example app')
param subnet1Name string

@sys.description('The subnet1 prefix, example 10.0.1.0/24')
param subnet1Prefix string

@sys.description('The subnet2 name, example database')
param subnet2Name string

@sys.description('The subnet2 prefix, example 10.0.2.0/24')
param subnet2Prefix string

// Create a virtual network
resource hubNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: hubNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        hubNetworkSpacePrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
        }
      }
    ]
  }
  tags: {
    environment: 'lab'
  }
}

// Output the vNet
output vNetworkID string = hubNetwork.id
output vNetworkName string = hubNetwork.name
output vNetworkLocation string = hubNetwork.location
output vNetworkSpacePrefix string = hubNetwork.properties.addressSpace.addressPrefixes[0]
output subnet1Name string = hubNetwork.properties.subnets[0].name
output subnet1Prefix string = hubNetwork.properties.subnets[0].properties.addressPrefix
output subnet2Name string = hubNetwork.properties.subnets[1].name
output subnet2Prefix string = hubNetwork.properties.subnets[1].properties.addressPrefix
