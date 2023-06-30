//
//  GetWeatherResponse.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation
import UIKit

struct GetWeatherResponse {
    let weatherUnits: [HourlyUnits]
    let weatherHourly: [Hourly]

    init(json: Any) throws {
        guard let array = json as? [String: Any] else { throw NetworkError.failInternetError }
        var weatherGetUnit = [HourlyUnits]()
        var weatherGetHourly = [Hourly]()
        var precipitation = [String]()
        var temperatupe = [String]()
        var windSpeed = [String]()
        var time = [String]()
        var iconImage = [String]()
        func modelDatFormat(StringDate: String) -> String {
            
            let dateString = StringDate + ":00Z"
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: dateString)
            
            let dateFormatterTime = ISO8601DateFormatter()
            dateFormatterTime.formatOptions = .withFullTime
            var strTime = dateFormatterTime.string(from: date!)
            strTime.removeLast(4)
            
            let dateFormatterDate = ISO8601DateFormatter()
            dateFormatterDate.formatOptions = .withFullDate
            let strDate = dateFormatterDate.string(from: date!)
            let strMD = String(strDate.dropFirst(5))
            return "\(strMD) \(strTime)"
        }
        
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
                    time.append(modelDatFormat(StringDate: i))
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
            let res = Hourly(time: time,
                             temperature2M: temperatupe,
                             precipitation: precipitation,
                             windspeed10M: windSpeed,
                             iconImage: iconImage )
            weatherGetHourly.append(res)
        }
        self.weatherUnits = weatherGetUnit
        self.weatherHourly = weatherGetHourly
    }
}



