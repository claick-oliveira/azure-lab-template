@sys.description('The bastion host name')
param bastionHostName string

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

@sys.description('The subnet ID')
param subnetId string

@sys.description('The public IP ID')
param publicIpId string

@sys.description('The vNet name')
param vNetname string

// Get the VNet
resource existingVirtualNetwork 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: vNetname
}

// Create the bastion host
resource bastionHost 'Microsoft.Network/bastionHosts@2022-01-01' = {
  name: bastionHostName
  location: location
  sku: {
    name: 'Standard'
  }
  dependsOn: [
    existingVirtualNetwork
  ]
  properties: {
    enableTunneling: true
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: publicIpId
          }
        }
      }
    ]
  }
  tags: {
    environment: 'lab'
  }
}
