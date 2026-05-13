using '../main.bicep'

param environment = 'dev'

param location = 'centralindia'

param projectName = 'platform'

param tags = {
  Environment : 'dev'
  Owner       : 'platform-team'
  CostCenter  : 'cloud'
  Project     : 'guardrails-demo'
}