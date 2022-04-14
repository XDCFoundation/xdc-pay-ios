// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let home = try? newJSONDecoder().decode(Home.self, from: jsonData)

import Foundation
import XDC3Swift
import BigInt


// MARK: - Home
struct Home: Codable {
    let responseData: [ResponseDatum]?
    let message: String?
    let success: Bool?
    let responseCode: Int?

    enum CodingKeys: String, CodingKey {
        case responseData = "responseData"
        case message = "message"
        case success = "success"
        case responseCode = "responseCode"
    }
}

// MARK: - ResponseDatum
struct ResponseDatum: Codable {
    let id: String?
    let commentsSize: Int?
    let contents: Contents?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case commentsSize = "commentsSize"
        case contents = "contents"
    }
}

// MARK: - Contents
struct Contents: Codable {
    let id: String?
    let saleData: SaleData?
    let buyer: Buyer?
    let seller: Buyer?
    let createdBy: Buyer?
    let updatedBy: Buyer?
    let status: Status?
    let ipfsurl: String?
    let cdnurl: String?
    let metadataurl: String?
    let thumbnailurl: String?
    let contentTokenid: String?
    let transactionHash: String?
    let title: String?
    let contentsDescription: String?
    let categories: [Category]?
    let videoType: VideoType?
    let comments: [String]?
    let hashtags: [JSONAny]?
    let flags: [JSONAny]?
    let tokenid: Double?
    let tokenAddress: String?
    let isDeleted: Bool?
    let isReported: Bool?
    let isActive: Bool?
    let addedOn: Int?
    let modifiedOn: Int?
    let year: Int?
    let likes: [Buyer]?
    let views: [JSONAny]?
    let shares: [JSONAny]?
    let reportedBy: [JSONAny]?
    let favoriteFor: [Buyer]?
    let pricingHistory: [PricingHistory]?
    let v: Int?
    let isLiked: Bool?
    let isFavourite: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case saleData = "saleData"
        case buyer = "buyer"
        case seller = "seller"
        case createdBy = "createdBy"
        case updatedBy = "updatedBy"
        case status = "status"
        case ipfsurl = "ipfsUrl"
        case cdnurl = "cdnUrl"
        case metadataurl = "metadataUrl"
        case thumbnailurl = "thumbnailUrl"
        case contentTokenid = "contentTokenId"
        case transactionHash = "transactionHash"
        case title = "title"
        case contentsDescription = "description"
        case categories = "categories"
        case videoType = "videoType"
        case comments = "comments"
        case hashtags = "hashtags"
        case flags = "flags"
        case tokenid = "tokenId"
        case tokenAddress = "tokenAddress"
        case isDeleted = "isDeleted"
        case isReported = "isReported"
        case isActive = "isActive"
        case addedOn = "addedOn"
        case modifiedOn = "modifiedOn"
        case year = "year"
        case likes = "likes"
        case views = "views"
        case shares = "shares"
        case reportedBy = "reportedBy"
        case favoriteFor = "favoriteFor"
        case pricingHistory = "pricingHistory"
        case v = "__v"
        case isLiked = "isLiked"
        case isFavourite = "isFavourite"
    }
}

// MARK: - Buyer
struct Buyer: Codable {
    let userid: String?
    let name: String?
    let email: String?
    let profilePicurl: String?
    let id: String?
    let addedOn: Int?
    let wallet: String?

    enum CodingKeys: String, CodingKey {
        case userid = "userId"
        case name = "name"
        case email = "email"
        case profilePicurl = "profilePicUrl"
        case id = "_id"
        case addedOn = "addedOn"
        case wallet = "wallet"
    }
}

enum Category: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Category.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Category"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PricingHistory
struct PricingHistory: Codable {
    let salePrice: Int?
    let addedOn: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case salePrice = "salePrice"
        case addedOn = "addedOn"
        case id = "_id"
    }
}

// MARK: - SaleData
struct SaleData: Codable {
    let isOpenForSale: Bool?
    let isExpired: Bool?
    let salePrice: Int?
    let isSold: Bool?
    let currency: Currency?
    let isScheduleForFuture: Bool?
    let availableForSaleIn: String?
    let expirationDate: String?

    enum CodingKeys: String, CodingKey {
        case isOpenForSale = "isOpenForSale"
        case isExpired = "isExpired"
        case salePrice = "salePrice"
        case isSold = "isSold"
        case currency = "currency"
        case isScheduleForFuture = "isScheduleForFuture"
        case availableForSaleIn = "availableForSaleIn"
        case expirationDate = "expirationDate"
    }
}

enum Currency: String, Codable {
    case empty = ""
    case xdc = "XDC"
}

enum Status: String, Codable {
    case draft = "DRAFT"
    case published = "PUBLISHED"
}

enum VideoType: String, Codable {
    case empty = ""
    case videoTypePublic = "Public"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


extension XRC721Functions {
    
    public struct testCheck: ABIFunction {
        public static let name = "mintAndTransfer"
        public var gasPrice: BigUInt?
        public var gasLimit: BigUInt?
        public var contract: XDCAddress
        public var from: XDCAddress?
        
        public let signer: XDCAddress
        public let message: String
        public let signature: Data
        public let tokenId: BigUInt
        public let uri: String
        public let nftPrice: BigUInt
        
        public init(contract: XDCAddress,
                    from: XDCAddress? = nil,
                    gasPrice: BigUInt? = nil,
                    gasLimit: BigUInt? = nil,
                    signer: XDCAddress,
                    message: String,
                    signature: Data,
                    tokenId: BigUInt,
                    uri: String,
                    nftPrice: BigUInt
                    ){
            self.contract = contract
            self.from = from
            self.gasPrice = gasPrice
            self.gasLimit = gasLimit
            self.signer = signer
            self.message = message
            self.signature = signature
            self.tokenId = tokenId
            self.uri = uri
            self.nftPrice = nftPrice
        }
        
        public func encode(to encoder: ABIFunctionEncoder) throws {
            try encoder.encode(signer)
            try encoder.encode(message)
            try encoder.encode(signature)
            try encoder.encode(tokenId)
            try encoder.encode(uri)
            try encoder.encode(nftPrice)
        }
        
       
    }
    
    
    public struct deploy: ABIFunction {
            public static let name = "deploy"
            public let gasPrice: BigUInt?
            public let gasLimit: BigUInt?
            public var contract: XDCAddress
            public let from: XDCAddress?
            
            
            public let nftName: String
            public let nftSymbol: String
            public let to: XDCAddress
            public let tokenId: BigUInt
            public let uri: String
            
            
            public init(contract: XDCAddress,
                        from: XDCAddress? = nil,
                        gasPrice: BigUInt? = nil,
                        gasLimit: BigUInt? = nil,
                        name: String,
                        symbol: String,
                        to: XDCAddress,
                        tokenId: BigUInt,
                        uri: String
                        ) {
                self.contract = contract
                self.from = from
                self.gasPrice = gasPrice
                self.gasLimit = gasLimit
                self.nftName = name
                self.nftSymbol = symbol
                self.to = to
                self.tokenId = tokenId
                self.uri = uri
            }
            
            public func encode(to encoder: ABIFunctionEncoder) throws {
                try encoder.encode(nftName)
                try encoder.encode(nftSymbol)
                try encoder.encode(to)
                try encoder.encode(tokenId)
                try encoder.encode(uri)
                
            }
        }
    
    public struct authorizeSpender: ABIFunction {
        public static let name = "authorizeSpender"
        public let gasPrice: BigUInt?
        public let gasLimit: BigUInt?
        public var contract: XDCAddress
        public let from: XDCAddress?
        
        
        public let _spender: XDCAddress
        public let _amount: BigUInt
      //  public let _authorize: Bool
        
        
        public init(contract: XDCAddress,
                    from: XDCAddress? = nil,
                    gasPrice: BigUInt? = nil,
                    gasLimit: BigUInt? = nil,
                    spender: XDCAddress,
                    amount: BigUInt
                   // authorize: Bool
                    ) {
            self.contract = contract
            self.from = from
            self.gasPrice = gasPrice
            self.gasLimit = gasLimit
            self._spender = spender
            self._amount = amount
        //    self._authorize = authorize
        }
        
        public func encode(to encoder: ABIFunctionEncoder) throws {
            try encoder.encode(_spender)
            try encoder.encode(_amount)
          //  try encoder.encode(_authorize)
        }
    }
    
    public struct buyerToSeller: ABIFunction {
        public static let name = "buyerToSeller"
        public let gasPrice: BigUInt?
        public let gasLimit: BigUInt?
        public var contract: XDCAddress
        public let from: XDCAddress?
        
        
        public let _recipient: XDCAddress
        public let _amount: BigUInt
        
        
        public init(contract: XDCAddress,
                    from: XDCAddress? = nil,
                    gasPrice: BigUInt? = nil,
                    gasLimit: BigUInt? = nil,
                    recipient: XDCAddress,
                    amount: BigUInt
                    ) {
            self.contract = contract
            self.from = from
            self.gasPrice = gasPrice
            self.gasLimit = gasLimit
            self._recipient = recipient
            self._amount = amount
        }
        
        public func encode(to encoder: ABIFunctionEncoder) throws {
            try encoder.encode(_recipient)
            try encoder.encode(_amount)
        }
    }

    
    public struct maximumAmount: ABIFunction {
        public static let name = "maximumAmount"
        public let gasPrice: BigUInt?
        public let gasLimit: BigUInt?
        public var contract: XDCAddress
        public let from: XDCAddress?
        
        public init(contract: XDCAddress,
                    from: XDCAddress? = nil,
                    gasPrice: BigUInt? = nil,
                    gasLimit: BigUInt? = nil) {
            self.contract = contract
            self.from = from
            self.gasPrice = gasPrice
            self.gasLimit = gasLimit
        }
        
        public func encode(to encoder: ABIFunctionEncoder) throws { }
    }
    
    
    
    public struct getTokenAddress: ABIFunction {
        public static let name = "getTokenAddress"
        public let gasPrice: BigUInt?
        public let gasLimit: BigUInt?
        public var contract: XDCAddress
        public let from: XDCAddress?
        
        public let _address: XDCAddress
        
        public init(contract: XDCAddress,
                    from: XDCAddress? = nil,
                    gasPrice: BigUInt? = nil,
                    gasLimit: BigUInt? = nil,
                    address: XDCAddress) {
            self.contract = contract
            self.from = from
            self.gasPrice = gasPrice
            self.gasLimit = gasLimit
            self._address = address
        }
        
        public func encode(to encoder: ABIFunctionEncoder) throws {
            try encoder.encode(_address)
        }
    }
}

extension XRC721Metadata {
    public func maximumAmount(contract: XDCAddress,
                           completion: @escaping((Error?, BigUInt?) -> Void)) {
        let function = XRC721Functions.maximumAmount(contract: contract)
        function.call(withClient: client, responseType: XRC721EnumerableResponses.numberResponse.self) { error, response in
            return completion(error, response?.value)
        }
    }
    
    public func getTokenAddress(contract: XDCAddress,
                        address: XDCAddress,
                        completion: @escaping((Error?, XDCAddress?) -> Void)) {
        let function = XRC721Functions.getTokenAddress(contract: contract, address: address)
        function.call(withClient: client,
                      responseType: XRC721Responses.ownerResponse.self) { (error, response) in
                        return completion(error, response?.value)
        }
    }
}


struct LikeData: Codable {
    let userid: String?
    let name: String?
    let email: String?
    let profilePicurl: String?
    let addedOn: Int?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case userid = "userId"
        case name = "name"
        case email = "email"
        case profilePicurl = "profilePicUrl"
        case addedOn = "addedOn"
        case id = "_id"
    }
}

// typealias LikeData = [LikeDatum]
