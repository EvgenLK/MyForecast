// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weaterData = try? JSONDecoder().decode(WeaterData.self, from: jsonData)

import Foundation

// MARK: - WeaterData
struct WeaterData: Codable {
    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - Hourly
extension WeaterData {
    struct Hourly: Codable {
        let time: [String]?
        let temperature2M, precipitation, windspeed10M: [Double]?
        
        enum CodingKeys: String, CodingKey {
            case time
            case temperature2M = "temperature_2m"
            case precipitation
            case windspeed10M = "windspeed_10m"
        }
    }
    
    // MARK: - HourlyUnits
    struct HourlyUnits: Codable {
    }
}
