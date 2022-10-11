targetScope = 'subscription'

param name string
param location string
param tags object = {}

// Set up the resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${name}'
  location: location
  tags: tags
}

// Set up the container registry
module acr 'br/my-acr:bicep/modules/azure-container-registry:0.1' = {
  scope: rg
  name: 'acrDeploy'
  params: {
    name: 'acr${toLower(name)}'
    location: location
    tags: tags
    sku: 'Basic'
    adminUserEnabled: false
    managedIdentityType: 'SystemAssigned'
    publicNetworkAccess: true
  }
}
