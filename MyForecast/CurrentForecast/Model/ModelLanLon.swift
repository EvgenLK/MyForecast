//
//  ModelLanLon.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation


struct ModelLanLon {
    let latitude: Double
    let longitude: Double
    
    init?(dictionary: [String: AnyObject]) {
        guard let latitude = dictionary["latitude"] as? Double,
              let longitude = dictionary["longitude"] as? Double
        else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
    }
}
