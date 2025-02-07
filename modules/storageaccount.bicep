@sys.description('The Storage Account name')
param storageAccountName string

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
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Premium_GRS'
])
param storageAccountSKU string

@allowed([
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
  'Storage'
])
param storageAccountKind string

@allowed([
  'Hot'
  'Cool'
])
param storageAccountTier string

// Create the storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSKU
  }
  kind: storageAccountKind
  properties: {
    accessTier: storageAccountTier
  }
  tags: {
    environment: 'lab'
  }
}

// Output the storage account
output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
output storageAccountLocation string = storageAccount.location
output storageAccountSKU string = storageAccount.sku.name
output storageAccountKind string = storageAccount.kind
output storageAccountTier string = storageAccount.properties.accessTier
