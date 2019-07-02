# TeamsMessageExtract

You can use this script to extract messages and replies from Teams, one of the Microsoft 365 product. 

## Usage

Call Export-TemsMessageAndReplies commandlet with arguments as below;

- ExportPath   
This script will create three json files with this parameter.
- TeamId   
You must set Teams ID. 
- ChannelId   
You must set Channel ID.
- AccessToken   
You must set access token which is generated from your Office 365 Tenant.
- QueryFilter
If you want to limit a number of record of users, you must set filter expression to this parameter. Further information for filter expression, please visit [here](https://docs.microsoft.com/en-us/graph/query-parameters#filter-parameter).
