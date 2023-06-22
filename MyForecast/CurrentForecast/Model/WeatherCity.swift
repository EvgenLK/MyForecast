// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weaterCity = try? JSONDecoder().decode(WeaterCity.self, from: jsonData)

import Foundation

struct City {
    let admin1: String
    let admin1_id: Int
    let admin2: String
    let admin2_id: Int
    let country: String
    let country_code: String
    let country_id: Int
    let elevation: Int
    let feature_code: String
    let id: Int
    let latitude: String
    let longitude: String
    let name: String
    let population: Int
    let timezone: String
}

struct RootObject {
    let generationtime_ms: String
    let results: [City]
}

