//
//  GetLanLon.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation

struct GetLanLon {
    let lanlon: [WeatherCity]
    
    init(json: Any) throws {
        guard let array = json as? [String: Any] else { throw NetworkError.failInternetError }
        
        var lanlons = [WeatherCity]()
        
        if let results = array["results"] as? [[String: Any]] {
            for result in results {
                guard let admin1 = result["admin1"] as? String else { continue }
                guard let admin1_id = result["admin1_id"] as? Int else { continue }
                guard let country = result["country"] as? String else { continue }
                guard let country_code = result["country_code"] as? String else { continue }
                guard let country_id = result["country_id"] as? Int else { continue }
                guard let elevation = result["elevation"] as? Int else { continue }
                guard let feature_code = result["feature_code"] as? String else { continue }
                guard let id = result["id"] as? Int else { continue }
                guard let latitude = result["latitude"] as? Double else { continue }
                guard let longitude = result["longitude"] as? Double else { continue }
                guard let name = result["name"] as? String else { continue }
                guard let population = result["population"] as? Int else { continue }
                guard let timezone = result["timezone"] as? String else { continue }
                
                let res = WeatherCity(id: id,
                                      name: name,
                                      latitude: latitude,
                                      longitude: longitude,
                                      elevation: elevation,
                                      featureCode: feature_code,
                                      countryCode: country_code,
                                      admin1ID: admin1_id,
                                      timezone: timezone,
                                      population: population,
                                      countryID: country_id,
                                      country: country,
                                      admin1: admin1)
                lanlons.append(res)
            }
        }
        self.lanlon = lanlons
    }
}


