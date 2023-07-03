//
//  CityNetworkService.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation

class WeatherNetworkService {
    init() {}
    
    func getLanLon(latitude: Double, longitude: Double, days: Int, completion: @escaping(WeatherResponse) ->()) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/gfs?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,precipitation,windspeed_10m&windspeed_unit=ms&forecast_days=\(String(days))&timezone=auto") else { return }
        
        NetworkService.shared.getData(url: url) { json in
            do {
                let response = try WeatherResponse(json: json)
                completion(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
