//
//  GetWeatherResponse.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation

struct GetWeatherResponse {
    let weatherUnits: [HourlyUnits]
    let weatherHourly: [Hourly]
    
    init(json: Any) throws {
        guard let array = json as? [String: Any] else { throw NetworkError.failInternetError }
        var weatherGetUnit = [HourlyUnits]()
        var weatherGetHourly = [Hourly]()
        
        if let hourleUnits = array["hourly_units"] as? [[String: Any]] {
            for arrayElem in hourleUnits {
                
                guard let timeiso8601 = arrayElem["time"] as? String else { continue }
                guard let temperature_2m = arrayElem["temperature_2m"] as? String else { continue }
                guard let precipitationMM = arrayElem["precipitation"] as? String else { continue }
                guard let windspeed_10ms = arrayElem["windspeed_10m"] as? String else { continue }
                
                let res = HourlyUnits(time: timeiso8601,
                                      temperature2M: temperature_2m,
                                      precipitation: precipitationMM,
                                      windspeed10M: windspeed_10ms)
                weatherGetUnit.append(res)
                print(res)
            }
        }
        
        if let hourle = array["hourly"] as? [String: Any] {
            var precipitation = [Double]()
            var temperatupe = [Double]()
            var windSpeed = [Double]()
            var time = [String]()
            
            if let precipitationArray = hourle["precipitation"] as? [Double] {
                for value in precipitationArray {
                    precipitation.append(value)
                }
            }
            
            if let temperatureArray = hourle["temperature_2m"] as? [Double] {
                for value in temperatureArray {
                    temperatupe.append(value)
                }
            }
            
            if let windspeedArray = hourle["windspeed_10m"] as? [Double] {
                for value in windspeedArray {
                    windSpeed.append(value)
                }
            }
            
            if let timeArray = hourle["time"] as? [String] {
                for value in timeArray {
                    time.append(value)
                }
            }
            
            let res = Hourly(time: time,
                             temperature2M: temperatupe,
                             precipitation: precipitation,
                             windspeed10M: windSpeed)
            weatherGetHourly.append(res)
        }
        self.weatherUnits = weatherGetUnit
        self.weatherHourly = weatherGetHourly
    }
}



