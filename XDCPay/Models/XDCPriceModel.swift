// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getXDCPrice = try? newJSONDecoder().decode(GetXDCPrice.self, from: jsonData)

import Foundation

// MARK: - GetXDCPrice
struct GetXDCPrice: Codable {
    let responseData: [XDCResponseDatum]?
    let message: String?
    let success: Bool?
    let responseCode: Int?
}

// MARK: - ResponseDatum
struct XDCResponseDatum: Codable {
    let responseDatumID: Int?
    let name, symbol, slug: String?
    let numMarketPairs: Int?
    let dateAdded: String?
    let lastUpdated, errorCode: Int?
    let errorMessage: XDCJSONNull?
    let creditCount: Int?
    let maxSupply: XDCJSONNull?
    let circulatingSupply, totalSupply: Double?
    let cmcRank, isFiat: Int?
    let fiatValue: String?
    let price: Double?
    let pricePercentChangePerHour: String?
    let marketCap, fullyDilutedMarketCap, volume, volumeMarketCap: Double?
    let quote: [Quote]?
    let modifiedOn, createdOn: Int?
    let isDeleted, isActive: Bool?
    let id: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case responseDatumID = "id"
        case name, symbol, slug, numMarketPairs, dateAdded, lastUpdated, errorCode, errorMessage, creditCount, maxSupply, circulatingSupply, totalSupply, cmcRank, isFiat, fiatValue, price, pricePercentChangePerHour, marketCap, fullyDilutedMarketCap, volume, volumeMarketCap, quote, modifiedOn, createdOn, isDeleted, isActive
        case id = "_id"
        case v = "__v"
    }
}

// MARK: - Quote
struct Quote: Codable {
    let usd: Usd?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct Usd: Codable {
    let price, volume24H, volumeChange24H, percentChange1H: Double?
    let percentChange24H, percentChange7D, percentChange30D, percentChange60D: Double?
    let percentChange90D, marketCap, marketCapDominance, fullyDilutedMarketCap: Double?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume_24h"
        case volumeChange24H = "volume_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case percentChange30D = "percent_change_30d"
        case percentChange60D = "percent_change_60d"
        case percentChange90D = "percent_change_90d"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case fullyDilutedMarketCap = "fully_diluted_market_cap"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Encode/decode helpers

class XDCJSONNull: Codable, Hashable {

    public static func == (lhs: XDCJSONNull, rhs: XDCJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(XDCJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
