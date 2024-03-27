[English](README.md) | [日本語](README.ja.md)

# Apex Stub Web Service
A simple, portable, and customizable stub API for Salesforce development. The common usecase is stubbing a REST API for integration tests, for example, when you cannot wait until the actual API is available.

![](img/overview.png)

## Setup
### Org for Stub Webservice
1. Add `"ZipSupportInApex"` feature to your scratch org definition file and create a scratch org with it.

2. Install the package or deploy `stub-webservice` folder in this repository.

3. Copy consumer key and consumer secret of the Connected App named `Apex Stub Webservice`. You'll use them later.

### Org for Integration Development
1. Install the package or deploy `app-sample` folder in this repository.

2. Update consumer key and consumer secret field of the Auth. Provider named `Stub API`.

3. Copy `Callback URL`. Back to the org for stub webservice and update the callback url field of the Connected App with it.

4. Update url of the named Named Credential `Stub API` with the org url for stub webservice.

5. Navigate to the External Credential named `Stub API`. And click `Authenticate` under action button in `Example` principal. 

6. Login to the org for stub webservice and authorize access.

## Optional Setup for Sample App

### Org for Stub Webservice
1. Install the package or deploy `stub-webservice-sample` folder.

###  Org for Integration Development
1. Assign permission set `Apex Stub Webservice Sample App` to your user.

2. Add `Purchase History` custom lighting component to account record page and update Account Number field of an account to `0001` or `0002`.