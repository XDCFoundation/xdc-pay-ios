
struct AllNetworks: Codable {
        
    var responseData: [Network]?

        enum CodingKeys: String, CodingKey {
            case responseData = "response"
        }
}

    // MARK: - ResponseDatum
struct Network: Codable {
        
        var name: String = ""
        var rpc: String = ""
        var id: String = ""
        var symbol: String = ""
        var url: String = ""
        var isEditable: String = ""

        enum CodingKeys: String, CodingKey {
            case name = "name"
            case rpc = "rpc"
            case id = "id"
            case symbol = "symbol"
            case url = "url"
            case isEditable = "isEditable"
        }
}

 
 struct AllAccounts: Codable {
         
     var responseData: [Account]?

         enum CodingKeys: String, CodingKey {
             case responseData = "response"
         }
     }

     // MARK: - ResponseDatum
 struct Account: Codable {
         
         var rawPrivateKey = ""
         var rawPublicKey = ""
         var privateKey = ""
         var address = ""
         var accountName = ""
         var canDelete = ""


         enum CodingKeys: String, CodingKey {
             case rawPrivateKey = "rawPrivateKey"
             case rawPublicKey = "rawPublicKey"
             case privateKey = "privateKey"
             case address = "address"
             case accountName = "accountName"
             case canDelete = "canDelete"
         }
 }
 



struct AllTransactions: Codable {
        
    var responseData: [Transaction]?

        enum CodingKeys: String, CodingKey {
            case responseData = "response"
        }
    }

    // MARK: - ResponseDatum
struct Transaction: Codable {
        
        var gwei = ""
        var recipientAddress = ""
        var amount = ""
        var gasLimit = ""
        var hash = ""
        var fee = ""
        var total = ""
        var myAddress = ""
        var time = ""


        enum CodingKeys: String, CodingKey {
            case gwei = "gwei"
            case recipientAddress = "recipientAddress"
            case amount = "amount"
            case gasLimit = "gasLimit"
            case hash = "hash"
            case fee = "fee"
            case total = "total"
            case myAddress = "myAddress"
            case time = "time"
        }
}

