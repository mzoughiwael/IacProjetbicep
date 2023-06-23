param location string = resourceGroup().location
param tenantId string
param objectId string



resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: 'pfeIacKv'
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: objectId
        permissions: {
          secrets: ['get', 'set']
        }
      }
    ]
  }
}
