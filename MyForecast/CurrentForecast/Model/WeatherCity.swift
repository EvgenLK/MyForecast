
import Foundation

// MARK: - Result
struct WeatherCity: Codable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let elevation: Int
    let featureCode, countryCode: String
    let admin1ID: Int
    let timezone: String
    let population, countryID: Int
    let country, admin1: String

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
