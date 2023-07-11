
param plocation string =  resourceGroup().location
param padminUsername string = 'chabbouh'



resource keyVault1 'Microsoft.KeyVault/vaults@2022-11-01' existing = {
    name:'pfeIacKv' 

  }


module machineVirtuel 'machineVirtuel.bicep' = {
    name: 'machineVirtuel'
    params:{
        
        padminPassword: keyVault1.getSecret('kvs1')
        padminUsername: padminUsername
        plocation: plocation
    }
    
 
}


