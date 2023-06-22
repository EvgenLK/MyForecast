//
//  GetLanLon.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation

struct GetLanLon {
    let lanlon: [City]
    
    init(json: Any) throws {
        guard let array = json as? [String: Any] else { throw NetworkError.failInternetError }
        
        var lanlons = [City]()
        
        
        if let results = array["results"] as? [[String: Any]] {
            for result in results {
                let admin1 = result["admin1"] as? String ?? ""
                let admin1_id = result["admin1_id"] as? Int ?? 0
                let admin2 = result["admin2"] as? String ?? ""
                let admin2_id = result["admin2_id"] as? Int ?? 0
                let country = result["country"] as? String ?? ""
                let country_code = result["country_code"] as? String ?? ""
                let country_id = result["country_id"] as? Int ?? 0
                let elevation = result["elevation"] as? Int ?? 0
                let feature_code = result["feature_code"] as? String ?? ""
                let id = result["id"] as? Int ?? 0
                let latitude = result["latitude"] as? String ?? ""
                let longitude = result["longitude"] as? String ?? ""
                let name = result["name"] as? String ?? ""
                let population = result["population"] as? Int ?? 0
                let timezone = result["timezone"] as? String ?? ""
                
                let res = City(admin1: admin1,
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


