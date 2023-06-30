// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)

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

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    let time, temperature2M, precipitation, windspeed10M: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case precipitation
        case windspeed10M = "windspeed_10m"
    }
}
