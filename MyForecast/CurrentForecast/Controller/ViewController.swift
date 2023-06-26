//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit



class ViewController: UIViewController, ButtonDelegate, CurentWeatherDelegate {

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
        customViewCurent.delegateWeather = self
        customViewCurent.updateUI()
    }
    
    func didUpdateWeatherHourly(weatherDataHourly: [Hourly]) {
        self.weatherHourly = weatherDataHourly
    }
    
    func didPressButton(city: String, day: String ) {
        self.cityUtf8 = CityUtf8.getCityUtf8(city: city)
        
        LanLonCityNetworkService.getLanLon(city: cityUtf8, day: day) { response in
            self.lanlon = response.lanlon
            
            WeatherNetworkService.getLanLon(latitude: self.lanlon[0].latitude, longitude: self.lanlon[0].longitude, days: day ) { response in
                self.weatherUnit = response.weatherUnits
                self.weatherHourly = response.weatherHourly
                DispatchQueue.main.async {
                    self.customViewCurent.updatedWeatherHourly = self.weatherHourly
                    print(self.weatherHourly)
                    self.customViewCurent.collectionView.reloadData()
                }
            }
        }
    }
}
    



