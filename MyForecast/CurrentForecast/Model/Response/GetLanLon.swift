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
                guard let admin2 = result["admin2"] as? String else { continue }
                guard let admin2_id = result["admin2_id"] as? Int else { continue }
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
                
                let res = WeatherCity(admin1: admin1,
                               admin1_id: admin1_id,
                               admin2: admin2,
                               admin2_id: admin2_id,
                               country: country,
                               country_code: country_code,
                               country_id: country_id,
                               elevation: elevation,
                               feature_code: feature_code,
                               id: id,
                               latitude: latitude,
                               longitude: longitude,
                               name: name,
                               population: population,
                               timezone: timezone)
                lanlons.append(res)
            }
        }
        self.lanlon = lanlons
    }
}


