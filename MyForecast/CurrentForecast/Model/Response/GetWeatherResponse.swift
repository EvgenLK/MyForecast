//
//  GetWeatherResponse.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation

struct GetWeatherResponse {
    let weatherData: [WeatherData]
    
    init(json: Any) throws {
        guard let array = json as? [String: Any] else { throw NetworkError.failInternetError }
        let weatherGetData = [WeatherData]()
        
        
        
        self.weatherData = weatherGetData
    }
}
