//
//  NetworkService.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation

class CityUtf8 {
    
    static func getCityUtf8(city: String) -> String {
        var cityUtf8: String = ""
        if "language".localized == "ru" {
            cityUtf8 = city.replacingOccurrences(of: " ", with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
        } else {
            cityUtf8 = city.replacingOccurrences(of: " ", with: "")
        }
        return cityUtf8
    }
    
}
