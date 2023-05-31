//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit

class ViewController: UIViewController{
    let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
    var myCurrentTemp = UILabel()
    var myCurrentPrecipitation = UILabel()
    var myCurrentWind = UILabel()
    var myTextFieldTemperature = UITextField()
    var myTFDaysForeC = UITextField()
    var myCurrentDate = UILabel()
    var myIconWeather: [String] = []

    var myButtonTemperature = UIButton()
    let queue = DispatchQueue(label: "thred-save-inArray", attributes: .concurrent)
    var arrayCityForecast: [String] = []
    var dataForecastWeather: [modelForecast] = []
    
    var currentHour: Int = {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }()
    var currentDateforLabel: String = {
       
        let currentDateTime = Date()
        let formatter = DateFormatter()

        formatter.timeStyle = .short
        formatter.dateStyle = .short
        let updDate = formatter.string(from: currentDateTime)
        
        return updDate
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackGround()
        setupLabel()
//        myTFDaysForeC.delegate = self
        setupButtonTemp()
        self.title = "My Forest Weather"
        setupTFDayForeCAst()
        setupTextField()
        colView()
        
        myTFDaysForeC.keyboardType = .numberPad

    }
    
    
    func setupButtonTemp() {

        myButtonTemperature = UIButton(frame: CGRect(x: 150 , y: 210, width: 100, height: 50))
        myButtonTemperature.layer.cornerRadius = 15
        myButtonTemperature.setTitle("searh_button".localized, for: .normal)
        myButtonTemperature.backgroundColor = .blue
        myButtonTemperature.setTitleColor(.systemBlue, for: .highlighted)
        myButtonTemperature.setTitle("searh_button".localized, for: .highlighted)
        myButtonTemperature.layer.borderWidth = 0.5
        myButtonTemperature.addTarget(self, action: #selector(requestForecastWeather), for: .touchUpInside)

        view.addSubview(myButtonTemperature)

        
    }

    
    @objc func requestForecastWeather() {
        myTextFieldTemperature.resignFirstResponder()
        myTFDaysForeC.resignFirstResponder()

        
        if myTextFieldTemperature.text!.replacingOccurrences(of: " ", with: "") != ""{
            myCurrentTemp.text = "loading_view".localized
            
            let urlCityString = "https://geocoding-api.open-meteo.com/v1/search?name=\(myTextFieldTemperature.text!.replacingOccurrences(of: " ", with: ""))&count=1&language=en&format=json"
            
            guard let urlcity = URL(string: urlCityString) else { return }
            let requestCity = URLRequest(url: urlcity)
            
            let taskCity = URLSession.shared.dataTask(with: requestCity) { data, response, error in
                if let data, let city = try? JSONDecoder().decode(WeaterCity.self, from: data) {
                    self.arrayCityForecast.removeAll()
                    
                    self.queue.async(flags: .barrier) {
                        guard let dataArray = city.results else { return }
                        for elem in dataArray {
                            guard let lat = elem.latitude else {return}
                            guard let lon = elem.longitude else {return}
                            self.arrayCityForecast.append(String(format:"%.02f", lat))
                            self.arrayCityForecast.append(String(format:"%.02f", lon))
                            self.updateTupleAsync()
                        }
                    }
                    
                } else {
                    print("Fail")
                }
            }
            taskCity.resume()
            
            var boolCity = false
            
            while !boolCity {
                sleep(1)
                if !self.arrayCityForecast.isEmpty {
                    boolCity = true
                }
            }

            if boolCity == true {
                
                let forecastDaysWeather: String = myTFDaysForeC.text!.isEmpty ? "1" : String(myTFDaysForeC.text!)
                let urlString = "https://api.open-meteo.com/v1/gfs?latitude=\(self.arrayCityForecast[0])&longitude=\(self.arrayCityForecast[1])&hourly=temperature_2m,precipitation,windspeed_10m&windspeed_unit=ms&forecast_days=\(forecastDaysWeather)&timezone=auto"
                
                guard let url = URL(string: urlString) else { return }
                let request = URLRequest(url: url)
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data, let weather = try? JSONDecoder().decode(WeaterData.self, from: data) {

                        self.queue.async(flags: .barrier){ [weak self] in
                            self!.dataForecastWeather.removeAll()

                            for elem in 0..<24 * Int(forecastDaysWeather)!{
                                if elem % 4 == 0{
                                    guard let temp = weather.hourly?.temperature2M![elem] else { return }
                                    guard let precipitation = weather.hourly?.precipitation![elem] else { return }
                                    guard let windSpeed = weather.hourly?.windspeed10M![elem] else { return }
                                    guard let StringDate = weather.hourly?.time![elem] else { return }
                                    
                                    
                                    let dayForecast = modelForecast(date: modelDatFormat(StringDate: StringDate),
                                                                    temp: String(Int(temp)),
                                                                    windSpeed: String(Double(windSpeed)),
                                                                    precipitation: String(Double(precipitation)),
                                                                    imageIcon: modelimageIcon(precipitation: Int(precipitation), elem: elem))
                                    self?.dataForecastWeather.append(dayForecast)
                                }
                            }
                            
                            self?.updateArrAsync()

                        }
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let temp = weather.hourly?.temperature2M![self!.currentHour] else {return}
                            guard let precipitation = weather.hourly?.precipitation![self!.currentHour] else {return}
                            guard let windSpeed = weather.hourly?.windspeed10M![self!.currentHour] else {return}
                            
                            self?.myCurrentTemp.text = "\(Int(temp))" + "℃"
                            self?.myCurrentPrecipitation.text = "\(String(precipitation)) mm"
                            self?.myCurrentWind.text = "\(String(windSpeed)) m/s"
                            self?.myCurrentDate.text = self?.currentDateforLabel
                            
                            
                        }
                    } else {
                        print("Fail")
                    }
                }
                task.resume()
            }else {
                let alert = UIAlertController(title: "", message: "alert_not_city_request".localized, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "alert_message_empty_city".localized, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
        
    func updateArrAsync() {
        DispatchQueue.main.async {
            _ = self.dataForecastWeather
            self.collectionView.reloadData()
        }
    }
    func updateTupleAsync() {
        DispatchQueue.main.async {
            _ = self.arrayCityForecast

        }
    }


        func setupLabel() {
            
            myCurrentDate = UILabel(frame: CGRect(x: 10, y: 350, width: view.bounds.width, height: 40))
            myCurrentDate.font = UIFont(name: "ArialMT", size: 40)
            myCurrentDate.textColor = .white
            myCurrentDate.numberOfLines = 0
            myCurrentDate.textAlignment = .center
            
            myCurrentTemp = UILabel(frame: CGRect(x: 10, y: 380, width: view.bounds.width, height: 100))
            myCurrentTemp.font = UIFont(name: "ArialMT", size: 50)
            myCurrentTemp.textColor = .white
            myCurrentTemp.text = "current_temp_view".localized
            myCurrentTemp.numberOfLines = 0
            myCurrentTemp.textAlignment = .center
            
            myCurrentPrecipitation = UILabel(frame: CGRect(x: 10, y: 440, width: view.bounds.width, height: 100))
            myCurrentPrecipitation.font = UIFont(name: "ArialMT", size: 50)
            myCurrentPrecipitation.textColor = .white
            myCurrentPrecipitation.numberOfLines = 0
            myCurrentPrecipitation.textAlignment = .center
            
            myCurrentWind = UILabel(frame: CGRect(x: 10, y: 500, width: view.bounds.width, height: 100))
            myCurrentWind.font = UIFont(name: "ArialMT", size: 50)
            myCurrentWind.textColor = .white
            myCurrentWind.numberOfLines = 0
            myCurrentWind.textAlignment = .center
            
            self.view.addSubview(myCurrentTemp)
            self.view.addSubview(myCurrentPrecipitation)
            self.view.addSubview(myCurrentWind)
            self.view.addSubview(myCurrentDate)


        }
        
        func setupTextField() {
            
            
            myTextFieldTemperature = UITextField(frame: CGRect(x: 90, y: 100, width: self.view.bounds.width / 2 + 30, height: 40))
            myTextFieldTemperature.backgroundColor = .white
            myTextFieldTemperature.placeholder = "placeholder_in_view".localized
            myTextFieldTemperature.layer.cornerRadius = 10
            myTextFieldTemperature.layer.opacity = 0.5
            view.addSubview(myTextFieldTemperature)

        }
    
    func setupTFDayForeCAst() {
            
        
        myTFDaysForeC = UITextField(frame: CGRect(x: 90, y: 150, width: self.view.bounds.width / 2 + 30, height: 40))
        myTFDaysForeC.backgroundColor = .white
        myTFDaysForeC.placeholder = "placeholder_in_day_Forecast".localized
        myTFDaysForeC.layer.cornerRadius = 10
        myTFDaysForeC.layer.opacity = 0.5
        view.addSubview(myTFDaysForeC)
    }
    
        
        func setupBackGround() {
            
            switch(currentHour) {
            case 0,1,2,3,4,5,20,21,22,23,24:
                
                backGroundImage.image = UIImage(named: "Night")
                backGroundImage.contentMode = .scaleAspectFill
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

            default:
                
                backGroundImage.image = UIImage(named: "GoodDay")
                backGroundImage.contentMode = .scaleAspectFill
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            }
            view.addSubview(backGroundImage)

        }
      
    func colView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height/1.3 + 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            
        ])

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        layout.scrollDirection = .horizontal
        cv.layer.opacity = 0.6
        cv.layer.cornerRadius = 20
        cv.showsHorizontalScrollIndicator = false
        
        return cv

    }()
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForecastWeather.count != 0 ? dataForecastWeather.count: 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        if dataForecastWeather.count != 0{
            
            cell.myHour.text = "\(dataForecastWeather[indexPath.row].date)"
            cell.myTemp.text = "\(dataForecastWeather[indexPath.row].temp) ℃"
            cell.myRain.text = "\(dataForecastWeather[indexPath.row].precipitation)  mm"
            cell.myWindSpeed.text = "\(dataForecastWeather[indexPath.row].windSpeed)  m/s"
            cell.myImage.image = UIImage(named: dataForecastWeather[indexPath.row].imageIcon)
        } else {
            cell.myTemp.text = "forecast_collectionview".localized
        }
        
        return cell
    }
    

}
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
    

    
    

    



