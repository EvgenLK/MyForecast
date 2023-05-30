//
//  ModelDataWeather.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 30.05.2023.
//

import Foundation

struct modelForecast {
    var date: String
    var temp: String
    var windSpeed: String
    var precipitation: String
    var imageIcon: String
}

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
    var strMD = String(strDate.dropFirst(5))
    return "\(strMD) \(strTime)"
}

func modelimageIcon(precipitation: Int, elem: Int) -> String {
    
    var iconImage = ""
    
    switch elem {
    case 0,1,2,3,4,5,20,21,22,23,24:
        if precipitation == 0 {
            iconImage = "clearnight"
        } else if Double(precipitation) > 0.5 {
            iconImage = "rainNight"
        }
    default:
        if precipitation == 0{
            iconImage = "sun"
        } else if Double(precipitation) > 0.5 {
            iconImage = "rain"
        }
    }
    return iconImage
}
