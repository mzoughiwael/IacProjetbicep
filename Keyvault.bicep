param location string = resourceGroup().location

param tenantId string = subscription().tenantId

param objectId string = '274fe8d6-8e30-429b-9325-efe88ec28e11'



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
