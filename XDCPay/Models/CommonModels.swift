 
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

        enum CodingKeys: String, CodingKey {
            case name = "name"
            case rpc = "rpc"
            case id = "id"
            case symbol = "symbol"
            case url = "url"
        }
}
