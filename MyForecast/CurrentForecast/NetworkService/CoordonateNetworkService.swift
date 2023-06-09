//
//  LanLonCityNetworkService.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation

class CoordonateNetworkService {
    init() {}
    
    func getLanLon(city: String, day: Int, completion: @escaping(GetLanLon) ->()) {
        guard let url = URL(string: "https://geocoding-api.open-meteo.com/v1/search?name=\(city)&count=1&language=\("language".localized)&format=json")  else { return }
        
        NetworkService.shared.getData(url: url) { json in
            do {
                let response = try GetLanLon(json: json)
                completion(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
