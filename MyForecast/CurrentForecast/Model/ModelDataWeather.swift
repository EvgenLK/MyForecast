
import Foundation
import UIKit

struct ModelDataWeather {
    let time: String
    let temperature_2m: Double
    let windspeed_10m: Double
    let precipitation: Double
    let imageIcon: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let time = dictionary["time"] as? String,
              let temperature_2m = dictionary["temperature_2m"] as? Double,
              let windspeed_10m = dictionary["windspeed_10m"] as? Double,
              let precipitation = dictionary["precipitation"] as? Double,
              let imageIcon = dictionary["imageIcon"] as? String
        else { return nil }
        
        self.time = time
        self.temperature_2m = temperature_2m
        self.windspeed_10m = windspeed_10m
        self.precipitation = precipitation
        self.imageIcon = imageIcon
        
    }
}
