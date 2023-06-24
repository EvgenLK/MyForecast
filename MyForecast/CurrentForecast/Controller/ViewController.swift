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
    
    func didPressButton(city: String, day: String ) {
        self.cityUtf8 = CityUtf8.getCityUtf8(city: city)
        
        LanLonCityNetworkService.getLanLon(city: cityUtf8, day: day) { response in
            self.lanlon = response.lanlon
            
            WeatherNetworkService.getLanLon(latitude: self.lanlon[0].latitude, longitude: self.lanlon[0].longitude, days: day ) { response in
                self.weatherUnit = response.weatherUnits
                self.weatherHourly = response.weatherHourly
                print(self.weatherUnit)
                print(self.weatherHourly)
                
            }
        }
    }
    

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

