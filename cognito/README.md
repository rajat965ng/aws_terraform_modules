# Cognito

## User specific AWS-CLI commands

[Create user]
- aws cognito-idp admin-create-user --user-pool-id [value] --username testuser1

[Add user to group]
- aws cognito-idp admin-add-user-to-group --user-pool-id [value] --group-name [value] --username testuser1

