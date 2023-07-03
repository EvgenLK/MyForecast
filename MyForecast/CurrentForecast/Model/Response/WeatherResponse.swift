//
//  GetWeatherResponse.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation
import UIKit

struct WeatherResponse {
    let weatherUnits: [HourlyUnit]
    let weatherHourly: [Hourly]

    init(json: Any) throws {
        guard let array = json as? [String: Any] else { throw NetworkError.failInternetError }
        var weatherGetUnit = [HourlyUnit]()
        var weatherGetHourly = [Hourly]()
        var precipitation = [String]()
        var temperatupe = [String]()
        var windSpeed = [String]()
        var time = [String]()
        var iconImage = [String]()
        
        func modelDateFormat(StringDate: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            guard let date = inputFormatter.date(from: StringDate) else { return "" }
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM HH:mm"
            let formattedDate = outputFormatter.string(from: date)
            
            return formattedDate
        }
        
        if let hourleUnit = array["hourly_units"] as? [[String: Any]] {
            for arrayElem in hourleUnit {
                
                guard let timeiso8601 = arrayElem["time"] as? String else { continue }
                guard let temperature_2m = arrayElem["temperature_2m"] as? String else { continue }
                guard let precipitationMM = arrayElem["precipitation"] as? String else { continue }
                guard let windspeed_10ms = arrayElem["windspeed_10m"] as? String else { continue }
                
                let resultUnit = HourlyUnit(time: timeiso8601,
                                      temperature2M: temperature_2m,
                                      precipitation: precipitationMM,
                                      windspeed10M: windspeed_10ms)
                weatherGetUnit.append(resultUnit)
            }
        }
        if let hourle = array["hourly"] as? [String: Any] {
            if let precipitationArray = hourle["precipitation"] as? [Double] {
                for i in precipitationArray {
                    precipitation.append(String(i))
                    let imageNam = i < 0.2 ?  "sun" : "rain"
                    iconImage.append(imageNam)
                }
            }
            if let timeArray = hourle["time"] as? [String] {
                for i in timeArray {
                    time.append(modelDateFormat(StringDate: i))
                }
            }
            if let temperatureArray = hourle["temperature_2m"] as? [Double] {
                for i in temperatureArray {
                    temperatupe.append(String(i))
                }
            }
            if let windspeedArray = hourle["windspeed_10m"] as? [Double] {
                for i in windspeedArray {
                    windSpeed.append(String(i))
                }
            }
            let resultHourly = Hourly(time: time,
                             temperature2M: temperatupe,
                             precipitation: precipitation,
                             windspeed10M: windSpeed,
                             iconImage: iconImage )
            weatherGetHourly.append(resultHourly)
        }
        self.weatherUnits = weatherGetUnit
        self.weatherHourly = weatherGetHourly
    }
}



