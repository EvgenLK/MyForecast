//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit

class ViewController: UIViewController{
    let customViewCurent = CurentWeather()
    
    override func loadView() {
        view = customViewCurent
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Forest Weather"
        

    }
    

    
    //
    //    @objc func requestForecastWeather() {
    //        myTextFieldTemperature.resignFirstResponder()
    //        myTFDaysForeC.resignFirstResponder()
    //
    //
    //                let urlCityString = "https://geocoding-api.open-meteo.com/v1/search?name=\(cityUtf8)&count=1&language=\("language".localized)&format=json"
    //
    //
    //            guard let urlcity = URL(string: urlCityString) else { return }
    //            let requestCity = URLRequest(url: urlcity)
    //
    //            let taskCity = URLSession.shared.dataTask(with: requestCity) { data, response, error in
    //                if let data, let city = try? JSONDecoder().decode(WeaterCity.self, from: data) {
    //                    self.arrayCityForecast.removeAll()
    //
    //                    DispatchQueue.main.async {
    //                        guard let dataArray = city.results else { return }
    //                        for elem in dataArray {
    //                            guard let lat = elem.latitude else {return}
    //                            guard let lon = elem.longitude else {return}
    //                            self.arrayCityForecast.append(String(format:"%.02f", lat))
    //                            self.arrayCityForecast.append(String(format:"%.02f", lon))
    //                            self.updateTupleAsync()
    //                        }
    //                    }
    //
    //                } else {
    //                    print("Fail")
    //                }
    //            }
    //            taskCity.resume()
    //
    //            var boolCity = false
    //
    //            while !boolCity {
    //                var deadline = 3
    //                sleep(1)
    //                if !self.arrayCityForecast.isEmpty {
    //                    boolCity = true
    //                }else if deadline == 0 {
    //                    deadline -= 1
    //                    print("the end")
    //                    return
    //                }
    //            }
    //
    //            if boolCity == true {
    //
    //                let forecastDaysWeather: String = myTFDaysForeC.text!.isEmpty ? "1" : String(myTFDaysForeC.text!)
    //                let urlString = "https://api.open-meteo.com/v1/gfs?latitude=\(self.arrayCityForecast[0])&longitude=\(self.arrayCityForecast[1])&hourly=temperature_2m,precipitation,windspeed_10m&windspeed_unit=ms&forecast_days=\(forecastDaysWeather)&timezone=auto"
    //
    //                guard let url = URL(string: urlString) else { return }
    //                let request = URLRequest(url: url)
    //
    //                let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //                    if let data, let weather = try? JSONDecoder().decode(WeaterData.self, from: data) {
    //
    //                        self.queue.async(flags: .barrier){ [weak self] in
    //                            self!.dataForecastWeather.removeAll()
    //
    //                            for elem in 0..<24 * Int(forecastDaysWeather)!{
    //                                if elem % 4 == 0{
    //                                    guard let temp = weather.hourly?.temperature2M![elem] else { return }
    //                                    guard let precipitation = weather.hourly?.precipitation![elem] else { return }
    //                                    guard let windSpeed = weather.hourly?.windspeed10M![elem] else { return }
    //                                    guard let StringDate = weather.hourly?.time![elem] else { return }
    //
    //
    //                                    let dayForecast = modelForecast(date: modelDatFormat(StringDate: StringDate),
    //                                                                    temp: String(Int(temp)),
    //                                                                    windSpeed: String(Double(windSpeed)),
    //                                                                    precipitation: String(Double(precipitation)),
    //                                                                    imageIcon: modelimageIcon(precipitation: Int(precipitation), elem: elem))
    //                                    self?.dataForecastWeather.append(dayForecast)
    //                                }
    //                            }
    //
    //                            self?.updateArrAsync()
    //
    //                        }
    //
    //                        DispatchQueue.main.async { [weak self] in
    //                            guard let temp = weather.hourly?.temperature2M![self!.currentHour] else {return}
    //                            guard let precipitation = weather.hourly?.precipitation![self!.currentHour] else {return}
    //                            guard let windSpeed = weather.hourly?.windspeed10M![self!.currentHour] else {return}
    //
    //                            self?.myCurrentTemp.text = "\(Int(temp))" + "℃"
    //                            self?.myCurrentPrecipitation.text = "\(String(precipitation)) mm"
    //                            self?.myCurrentWind.text = "\(String(windSpeed)) m/s"
    //                            self?.myCurrentDate.text = self?.currentDateforLabel
    //
    //
    //                        }
    //                    } else {
    //                        print("Fail")
    //                    }
    //                }
    //                task.resume()
    //            }else {
    //                let alert = UIAlertController(title: "", message: "alert_not_city_request".localized, preferredStyle: UIAlertController.Style.alert)
    //                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //            }
    //
    //        } else {
    //            let alert = UIAlertController(title: "", message: "alert_message_empty_city".localized, preferredStyle: UIAlertController.Style.alert)
    //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    //            self.present(alert, animated: true, completion: nil)
    //        }
    //    }
    //
    //    func updateArrAsync() {
    //        DispatchQueue.main.async {
    //            _ = self.dataForecastWeather
    //            self.collectionView.reloadData()
    //        }
    //    }
    //    func updateTupleAsync() {
    //        DispatchQueue.main.async {
    //            _ = self.arrayCityForecast
    //
    //        }
    //    }
    //
    //
    //
    //
    //
}
    

