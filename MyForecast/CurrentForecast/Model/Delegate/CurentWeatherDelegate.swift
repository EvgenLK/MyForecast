//
//  CurentWeatherDelegate.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 25.06.2023.
//

import Foundation

protocol CurentWeatherDelegate: AnyObject {
    func didUpdateWeatherHourly(weatherDataHourly: [Hourly])
    func updateDidUI(weatherCurrent: [String: String])
    
}
