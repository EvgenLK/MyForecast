// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)

import Foundation


// MARK: - Hourly

    struct Hourly {
        let time: [String]
        let temperature2M: [Double]
        let precipitation: [Double]
        let windspeed10M: [Double]

    }

// MARK: - HourlyUnits

    struct HourlyUnits {
        let time, temperature2M, precipitation, windspeed10M: String

    }

