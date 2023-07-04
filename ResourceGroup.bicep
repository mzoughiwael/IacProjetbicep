param location string = 'eastus'

targetScope = 'subscription'

resource azbicepresourcegroupe 'Microsoft.Resources/resourceGroups@2022-09-01' ={
  
  name: 'pfeIacRg'
  location: location

}
