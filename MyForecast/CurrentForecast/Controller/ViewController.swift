//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit



class ViewController: UIViewController, ButtonDelegate {
    
    let customViewCurent = CurentWeather()
    var weather = [ModelDataWeather]()
    var lanlon = [WeatherCity]()
    var cityUtf8: String = ""
    var weatherUnit =  [HourlyUnits]()
    var weatherHourly =  [Hourly]()

    override func loadView() {
        view = customViewCurent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Forest Weather"
        customViewCurent.delegateTap = self
    }
//    var currentHour: Int = {
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        return hour
//    }()
    
//    func updateDidUI(weatherCurrent: [String: String]) {
//        var weatherCurent = [String: String]()
//        guard let weatherAll = self.weatherHourly.first else { return }
//        weatherCurent["time"] = weatherAll.time[currentHour]
//        weatherCurent["precip"] = weatherAll.precipitation[currentHour]
//        weatherCurent["temper"] = weatherAll.temperature2M[currentHour]
//        weatherCurent["windSpeed"] = weatherAll.windspeed10M[currentHour]
//
//        weatherCurent = weatherCurrent
//
//
//    }
    
    func didPressButton(city: String, day: String ) {
        self.cityUtf8 = CityUtf8.getCityUtf8(city: city)
        
        LanLonCityNetworkService.getLanLon(city: cityUtf8, day: day) { response in
            self.lanlon = response.lanlon
            WeatherNetworkService.getLanLon(latitude: self.lanlon[0].latitude, longitude: self.lanlon[0].longitude, days: day ) { response in
                self.weatherUnit = response.weatherUnits
                self.weatherHourly = response.weatherHourly
                DispatchQueue.main.async {
                    self.customViewCurent.updatedWeatherHourly = self.weatherHourly
                    self.customViewCurent.updateUICurent()
                    self.customViewCurent.collectionView.reloadData()
                }
            }
        }
    }
}
    



