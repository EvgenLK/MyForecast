// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weaterCity = try? JSONDecoder().decode(WeaterCity.self, from: jsonData)

import Foundation

// MARK: - WeaterCity
struct WeaterCity: Codable {
    let results: [Result]?
    let generationtimeMS: Double?

    enum CodingKeys: String, CodingKey {
        case results
        case generationtimeMS = "generationtime_ms"
    }
}

// MARK: - Result
extension WeaterCity {
    struct Result: Codable {
        let id: Int?
        let name: String?
        let latitude, longitude: Double?
        let elevation: Int?
        let featureCode, countryCode: String?
        let admin1ID: Int?
        let timezone: String?
        let population, countryID: Int?
        let country, admin1: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, latitude, longitude, elevation
            case featureCode = "feature_code"
            case countryCode = "country_code"
            case admin1ID = "admin1_id"
            case timezone, population
            case countryID = "country_id"
            case country, admin1
        }
    }
}
