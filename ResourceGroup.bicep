targetScope = 'subscription'

param location string = 'eastus'



resource azbicepresourcegroupe 'Microsoft.Resources/resourceGroups@2022-09-01' ={
  
  name: 'pfeIacRg1'
  location: location

}
