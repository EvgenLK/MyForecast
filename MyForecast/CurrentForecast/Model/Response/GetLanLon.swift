//
//  GetLanLon.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation

struct GetLanLon {
    typealias JSON = [[String: AnyObject]]
    let lanlon: [ModelLanLon]
    
    init(json: Any) throws {
        guard let array = json as? JSON else { throw NetworkError.failInternetError }
        
        var lanlons = [ModelLanLon]()
        
        for dictionary in array {
            guard let latlon = ModelLanLon(dictionary: dictionary) else { continue }
            lanlons.append(latlon)
            print("\(latlon) nen")
        }
        
        self.lanlon = lanlons
    }
}
