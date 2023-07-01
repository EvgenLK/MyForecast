
import Foundation


// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]
    let temperature2M, precipitation, windspeed10M: [String]
    let iconImage: [String]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case precipitation
        case windspeed10M = "windspeed_10m"
        case iconImage = "iconImage"
    }
}

// MARK: - HourlyUnit
struct HourlyUnit: Codable {
    let time, temperature2M, precipitation, windspeed10M: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case precipitation
        case windspeed10M = "windspeed_10m"
    }
}
