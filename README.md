# XDCPay ios #

### Usage ###

This Android application basically handle all Transactions related services like -
* List of transactions
* List of token
* List of Networks 
* Account Details
* Transaction Details
* Currency conversion 
* Current language
* State logs
* etc.

### Steps for local setup ###

* Clone the repository in your local system (X code) 
* Install CocoaPods
* Run application in your device or simulator 
* Dependencies : Defined under `Podfile.lock` 
* Deployment instructions : Upload build on testflight & push build on Appstore (For Live) 


### About XDCPay.xcworkspace folder ###

This folder is having different type of variable like DB url, PORT, microservice url etc.
* **env.development** : it have all variable which is use in mainnet environment.
* **env.prod** : it have all variable which is use for production environment.
