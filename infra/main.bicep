targetScope = 'resourceGroup'

@description('Environment name')
param environment string

@description('Deployment location')
param location string = resourceGroup().location

@description('Project name')
param projectName string

@description('Common tags')
param tags object

/*
========================================
Storage Account Name
========================================
*/

@description('Storage Account Name')
@maxLength(24)
param storageAccountName string = 'stguardrailsdev2568'

/*
========================================
Variables
========================================
*/

var keyVaultName = toLower('kv-${environment}-2568')

var logAnalyticsName = 'log-${environment}-${projectName}'

/*
========================================
Log Analytics Workspace
========================================
*/

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsName

  location: location

  tags: tags

  properties: {
    retentionInDays: 30

    sku: {
      name: 'PerGB2018'
    }

    features: {
      searchVersion: 1
    }
  }
}

/*
========================================
Storage Account
========================================
*/

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName

  location: location

  tags: tags

  sku: {
    name: 'Standard_GRS'
  }

  kind: 'StorageV2'

  properties: {
    accessTier: 'Hot'

    minimumTlsVersion: 'TLS1_2'

    supportsHttpsTrafficOnly: true

    allowBlobPublicAccess: false

    publicNetworkAccess: 'Disabled'

    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
  }
}

/*
========================================
Key Vault
========================================
*/

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName

  location: location

  tags: tags

  properties: {
    tenantId: subscription().tenantId

    sku: {
      family: 'A'
      name: 'standard'
    }

    enableRbacAuthorization: true

    enabledForDeployment: false

    enabledForTemplateDeployment: false

    enabledForDiskEncryption: false

    softDeleteRetentionInDays: 90

    enableSoftDelete: true

    enablePurgeProtection: true

    publicNetworkAccess: 'Disabled'

    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
  }
}

/*
========================================
Outputs
========================================
*/

output storageAccountNameOutput string = storage.name

output keyVaultNameOutput string = keyVault.name

output logAnalyticsNameOutput string = logAnalytics.name