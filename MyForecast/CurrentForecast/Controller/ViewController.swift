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
    var weatherData =  [WeatherData]()

    override func loadView() {
        view = customViewCurent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Forest Weather"
        customViewCurent.delegateTap = self
    }
    
    func didPressButton(city: String, day: String ) {
        self.cityUtf8 = CityUtf8.getCityUtf8(city: city)
        
        LanLonCityNetworkService.getLanLon(city: cityUtf8, day: day) { response in
            self.lanlon = response.lanlon
        }
        sleep(3)
        print(self.lanlon)
        WeatherNetworkService.getLanLon(latitude: lanlon[0].latitude, longitude: lanlon[0].longitude, days: day ){ response in
            self.weatherData = response.weatherData
        }
        
    }
    
// "https://api.open-meteo.com/v1/gfs?latitude=\(self.arrayCityForecast[0])&longitude=\(self.arrayCityForecast[1])&hourly=temperature_2m,precipitation,windspeed_10m&windspeed_unit=ms&forecast_days=\(forecastDaysWeather)&timezone=auto"
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
    

extension CurentWeather: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return weatherData.isEmpty ? weatherData.count: 1
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
//            let weather = dataForecastWeather[indexPath.row]
//            if dataForecastWeather.count != 0{
//                cell.configure(with: weather )
//            } else {
//                cell.myTemp.text = "forecast_collectionview".localized
//            }
        cell.myTemp.text = "not"
        return cell
        //}
        //}
    }
    
}

