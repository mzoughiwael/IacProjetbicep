param location string = resourceGroup().location

param tenantId string = subscription().tenantId

param objectId1 string = '274fe8d6-8e30-429b-9325-efe88ec28e11'

param objectId string = '02163390-530c-4cc1-ac2a-6db918773977'

param applicationId string = '8f2d2f0c-c0a7-41aa-a762-aa3cbdf0064a'

@secure()
param secretValue string


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
          secrets: [
            'get'
            'set'
            'list'
          ]
        }
      }
      
    ]
    enabledForDeployment: true
    enabledForTemplateDeployment: true
  }
}
resource symbolicname 'Microsoft.KeyVault/vaults/accessPolicies@2022-07-01' = {
  name: 'add'
  parent: keyVault
  properties: {
    accessPolicies: [
      {
        applicationId: applicationId
        objectId: objectId1
        permissions: {
          secrets: [
            'get'
            'set'
            'list'
          ]

        }
        tenantId: tenantId
      }
    ]
  }
}



resource secret 'Microsoft.KeyVault/vaults/secrets@2022-11-01' = {
  parent: keyVault
  name: 'kvs1'
  properties: {
    value: secretValue
  }


}
