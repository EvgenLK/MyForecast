//
//  CityNetworkService.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation

class WeatherNetworkService {
    private init() {}
    
    static func getWeather(city: String, day: String, completion: @escaping(GetWeatherResponse) ->()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments") else { return }
        
        NetworkService.shared.getData(url: url) { json in
            do {
                let response = try GetWeatherResponse(json: json)
                completion(response)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
