//
//  GetWeatherResponse.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation

struct GetWeatherResponse {
    typealias JSON = [[String: AnyObject]]
    let weather: [ModelDataWeather]
    
    init(json: Any) throws {
        guard let array = json as? JSON else { throw NetworkError.failInternetError }
        
        var weathers = [ModelDataWeather]()
        
        for dictionary in array {
            guard let weather = ModelDataWeather(dictionary: dictionary) else { continue }
            weathers.append(weather)
        }
        
        self.weather = weathers
    }
}
