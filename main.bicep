

param location string = resourceGroup().location


// Déclaration des paramètres



param vnetName string = 'chabbouhTestVnet'

param subnetName string = 'chabbouhTestSubnet'

param vmName string = 'chabbouhTestVm'

param adminUsername string = 'chabbouhUserName'

param diskSizeGb int = 128

param nsgName string = 'chabbouhNSG'



param adminPassword string = 'Marwen@12345'


 


// Création Virtual Network

resource vnet 'Microsoft.Network/virtualNetworks@2022-11-01' = {

  name: vnetName

  location: location

  properties: {

    addressSpace: {

      addressPrefixes: [

        '10.10.0.0/16'

      ]

    }

  }

}

 

// Création Subnet

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {

  parent: vnet

  name: subnetName

  properties: {

    addressPrefix: '10.10.0.0/24'

    networkSecurityGroup: {

      id: nsg.id

    }

  }

 // Création une ressource de groupe de sécurité réseau 

}

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {

  name: nsgName

  location: location

}

 

resource publicIp 'Microsoft.Network/publicIPAddresses@2021-02-01' = {

  name: '${vmName}-publicip'

  location: location

  properties: {

    publicIPAllocationMethod: 'Dynamic'

  }
  tags: {
    course: 'az900'
  }

}

 

resource nic 'Microsoft.Network/networkInterfaces@2022-11-01' = {

  name: '${vmName}-nic'

  location: location

 

  properties: {

    ipConfigurations: [

      {

        name: 'ipconfig'

        properties: {

          subnet: {

            id: subnet.id

          }

          privateIPAllocationMethod: 'Dynamic'

          publicIPAddress: {

            id: publicIp.id

          }

        }

      }

    ]

  }

}

 

// Création virtual Machine

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {

  name: vmName

  location: location

  properties: {

    hardwareProfile: {

      vmSize: 'Standard_A1_v2'

    }

    storageProfile: {

      imageReference: {

        publisher: 'Canonical'

        offer: 'UbuntuServer'

        sku: '18.04-LTS'

        version: 'latest'

      }

      osDisk: {

        createOption: 'FromImage'

        diskSizeGB: diskSizeGb

      }

    }

    osProfile: {

      computerName: vmName

      adminUsername: adminUsername

      adminPassword: adminPassword

      linuxConfiguration: {
        disablePasswordAuthentication: false
      }

    }

    networkProfile: {

      networkInterfaces: [

        {

          id: nic.id

        }

      ]

    }
 

  }

}


