//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit

class ViewController: UIViewController, InputActionDelegate {
    
    let customViewCurent = CurentWeather()
    var weather = [ModelDataWeather]()
    var lanlon = [WeatherCity]()
    var cityUtf8 = CityUtf8()
    var weatherUnit =  [HourlyUnit]()
    var weatherHourly =  [Hourly]()
    let weatherService = WeatherNetworkService()
    let CoordinateService = CoordonateNetworkService()
    
    override func loadView() {
        view = customViewCurent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Forest Weather"
        customViewCurent.delegateTap = self
    }
    
    func didPressSearchButton(city: String, day: Int) {
        if !city.isEmpty && (day > 0 && day < 8) {
            let city = cityUtf8.getCityUtf8(city: city)
            
            CoordinateService.getLanLon(city: city, day: day) { response in
                self.lanlon = response.lanlon
                self.weatherService.getLanLon(latitude: self.lanlon[0].latitude, longitude: self.lanlon[0].longitude, days: day) { response in
                    self.weatherUnit = response.weatherUnits
                    self.weatherHourly = response.weatherHourly
                    DispatchQueue.main.async {
                        self.customViewCurent.updatedWeatherHourly = self.weatherHourly
                        self.customViewCurent.updateUICurent()
                        self.customViewCurent.collectionView.reloadData()
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
            if city.isEmpty && (day < 1 || day > 7) {
                alert.message = "alert_not_textField_Search".localized
            } else if day < 1 || day > 7 {
                alert.message = "alert_message_empty_day".localized
            } else {
                alert.message = "alert_message_empty_city".localized
            }
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
