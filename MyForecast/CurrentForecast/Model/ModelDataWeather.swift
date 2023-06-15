//
//  ModelDataWeather.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 30.05.2023.
//

import Foundation
import UIKit

struct ModelDataWeather {
    let time: String
    let temperature_2m: Double
    let windspeed_10m: Double
    let precipitation: Double
    let imageIcon: UIImage?
    
    init?(dictionary: [String: AnyObject]) {
        guard let time = dictionary["time"] as? String,
              let temperature_2m = dictionary["temperature_2m"] as? Double,
              let windspeed_10m = dictionary["windspeed_10m"] as? Double,
              let precipitation = dictionary["precipitation"] as? Double,
              let imageIcon = dictionary["imageIcon"] as? UIImage
        else { return nil }
        
        self.time = time
        self.temperature_2m = temperature_2m
        self.windspeed_10m = windspeed_10m
        self.precipitation = precipitation
        self.imageIcon = imageIcon
        
    }
}




//func modelDatFormat(StringDate: String) -> String {
//    
//    let dateString = StringDate + ":00Z"
//    let dateFormatter = ISO8601DateFormatter()
//    let date = dateFormatter.date(from: dateString)
//    
//    
//    let dateFormatterTime = ISO8601DateFormatter()
//    dateFormatterTime.formatOptions = .withFullTime
//    var strTime = dateFormatterTime.string(from: date!)
//    strTime.removeLast(4)
//    
//    let dateFormatterDate = ISO8601DateFormatter()
//    dateFormatterDate.formatOptions = .withFullDate
//    let strDate = dateFormatterDate.string(from: date!)
//    let strMD = String(strDate.dropFirst(5))
//    return "\(strMD) \(strTime)"
//}
//
//func modelimageIcon(precipitation: Int, elem: Int) -> String {
//    
//    var iconImage = ""
//    
//    switch elem {
//    case 0,1,2,3,4,5,20,21,22,23,24:
//        if precipitation == 0 {
//            iconImage = "clearnight"
//        } else if Double(precipitation) > 0.5 {
//            iconImage = "rainNight"
//        }
//    default:
//        if precipitation == 0{
//            iconImage = "sun"
//        } else if Double(precipitation) > 0.5 {
//            iconImage = "rain"
//        }
//    }
//    return iconImage
//}
