# Cognito

## User specific AWS-CLI commands

[Create user]
- aws cognito-idp admin-create-user --user-pool-id [value] --username testuser1 --temporary-password tempPassword.123 --desired-delivery-mediums EMAIL --user-attributes Name=email,Value=testuser1@gmail.com Name=phone_number,Value=+919890123456

[Add user to group]
- aws cognito-idp admin-add-user-to-group --user-pool-id [value] --group-name [value] --username testuser1

[Initiate Auth]
-  aws  cognito-idp initiate-auth --client-id [value] --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=testuser1,PASSWORD=Admin.1234

[Respond to Auth]
- aws cognito-idp respond-to-auth-challenge --client-id [value] --challenge-name NEW_PASSWORD_REQUIRED --challenge-responses USERNAME=testuser1,NEW_PASSWORD=PermPassword.123 --session SESSION_VALUE

[Initial Auth with updated creds]
- aws cognito-idp initiate-auth --client-id [value] --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=testuser1,PASSWORD=PermPassword.123

[Generate new token using Refresh Token]
- aws cognito-idp initiate-auth --client-id [value] --auth-flow REFRESH_TOKEN --auth-parameters REFRESH_TOKEN=RefreshToken
