@sys.description('The vNet peering name')
param vNetPeeringName string

@sys.description('The vNet destination ID')
param vNetDestinationId string

@sys.description('The source network name')
param sourceNetworkname string

// Get the source network
resource sourceNetwork 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: sourceNetworkname
}

// Create a virtual network peering
resource vNetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  parent: sourceNetwork
  name: vNetPeeringName
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vNetDestinationId
    }
  }
}

// Output the vNet peering
output vNetPeeringId string = vNetPeering.id
output vNetPeeringName string = vNetPeering.name
