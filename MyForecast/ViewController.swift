//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit

class ViewController: UIViewController {
    let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
    var myCurrentTemp = UILabel()
    var myCurrentPrecipitation = UILabel()
    var myCurrentWind = UILabel()
    var myTextFieldTemperature = UITextField()
    var myCurrentDate = UILabel()
    var myIconWeather: [String] = []

    var myButtonTemperature = UIButton()
    var forecastWeatherDay: [String] = []
    let queue = DispatchQueue(label: "thred-save-inArray", attributes: .concurrent)
    let queueImage = DispatchQueue(label: "thred-save-image", attributes: .concurrent)
    var arrayCityForecast: [String] = []
    var forecastRain: [String] = []
    var forecastWindSpeed: [String] = []
    var forecastDate: [String] = []
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
        setupButtonTemp()
        self.title = "My Forest Weather"

        
        setupTextField()
        colView()
    }
    
    
    func setupButtonTemp() {

        myButtonTemperature = UIButton(frame: CGRect(x: 310, y: 95, width: 100, height: 50))
        myButtonTemperature.layer.cornerRadius = 15
        myButtonTemperature.setTitle("Search", for: .normal)
        myButtonTemperature.backgroundColor = .blue
        myButtonTemperature.setTitleColor(.systemBlue, for: .highlighted)
        myButtonTemperature.setTitle("Search", for: .highlighted)
        myButtonTemperature.layer.borderWidth = 0.5
        myButtonTemperature.addTarget(self, action: #selector(requestForecastWeather), for: .touchUpInside)

        view.addSubview(myButtonTemperature)

    }

    
    @objc func requestForecastWeather() {
        myTextFieldTemperature.resignFirstResponder()
        if myTextFieldTemperature.text!.replacingOccurrences(of: " ", with: "") != ""{
            myCurrentTemp.text = "Loading..."
            
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
            sleep(3)
            
            
            let urlString = "https://api.open-meteo.com/v1/gfs?latitude=\(self.arrayCityForecast[0])&longitude=\(self.arrayCityForecast[1])&hourly=temperature_2m,precipitation,windspeed_10m&windspeed_unit=ms&forecast_days=1&timezone=auto"
            
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data, let weather = try? JSONDecoder().decode(WeaterData.self, from: data) {
                    self.forecastWeatherDay.removeAll()
                    
                    self.queue.async(flags: .barrier){ [weak self] in
                        //
                        for elem in 0..<24{
                            if elem % 3 == 0{
                                guard let temp = weather.hourly?.temperature2M![elem] else {return}
                                self?.forecastWeatherDay.append(String(Int(temp)))
                            }
                        }

                        for elem in 0..<24{
                            if elem % 3 == 0{
                                guard let rain = weather.hourly?.precipitation![elem] else {return}
                                self?.forecastRain.append(String(Double(rain)))
                            }
                        }
                    
                        for elem in 0..<24{
                            if elem % 3 == 0{
                                guard let windSpeed = weather.hourly?.windspeed10M![elem] else { return }
                                self?.forecastWindSpeed.append(String(Double(windSpeed)))
                            }
                        }

                        for elem in 0..<24{
                            if elem % 3 == 0{
                                guard let StringDate = weather.hourly?.time![elem] else { return }
                                
                                let dateString = StringDate + ":00Z"
                                let dateFormatter = ISO8601DateFormatter()
                                let date = dateFormatter.date(from: dateString)
                                
                                let dateFormatter2 = ISO8601DateFormatter()
                                dateFormatter2.formatOptions = .withFullTime
                                var strDate = dateFormatter2.string(from: date!)
                                strDate.removeLast(4)
                                
                                self?.forecastDate.append(strDate)
                            }
                        }
                        

                            
                            for elem in 0..<24{
                                if elem % 3 == 0{
                                    guard let precipitation = weather.hourly?.precipitation![elem] else { return }
                                    
                                    switch elem {
                                    case 0,1,2,3,4,5,20,21,22,23,24:
                                        if precipitation == 0{
                                            self?.myIconWeather.append("clearNight")
                                        } else if precipitation > 1.0 {
                                            self?.myIconWeather.append("rainNight")
                                        }
                                    default:
                                        if precipitation == 0{
                                            self?.myIconWeather.append("sun")
                                        } else if precipitation > 1.0 {
                                            self?.myIconWeather.append("rain")
                                        }
                                        
                                    }
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
        } else {
            let alert = UIAlertController(title: "", message: "The city field cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        }
        
    func updateArrAsync() {
        DispatchQueue.main.async {
            _ = self.forecastWeatherDay
            _ = self.forecastRain
            _ = self.forecastWindSpeed
            _ = self.forecastDate
            _ = self.myIconWeather
            print(self.myIconWeather)
            self.collectionView.reloadData()
        }
    }
    func updateTupleAsync() {
        DispatchQueue.main.async {
            _ = self.arrayCityForecast

        }
    }


        func setupLabel() {
            
            myCurrentTemp = UILabel(frame: CGRect(x: 10, y: 180, width: view.bounds.width, height: 100))
            myCurrentTemp.font = UIFont(name: "ArialMT", size: 50)
            myCurrentTemp.textColor = .white
            myCurrentTemp.text = "Enter the city"
            myCurrentTemp.numberOfLines = 0
            myCurrentTemp.textAlignment = .center
            
            myCurrentPrecipitation = UILabel(frame: CGRect(x: 10, y: 330, width: view.bounds.width, height: 100))
            myCurrentPrecipitation.font = UIFont(name: "ArialMT", size: 50)
            myCurrentPrecipitation.textColor = .white
            myCurrentPrecipitation.numberOfLines = 0
            myCurrentPrecipitation.textAlignment = .center
            
            myCurrentWind = UILabel(frame: CGRect(x: 10, y: 380, width: view.bounds.width, height: 100))
            myCurrentWind.font = UIFont(name: "ArialMT", size: 50)
            myCurrentWind.textColor = .white
            myCurrentWind.numberOfLines = 0
            myCurrentWind.textAlignment = .center
            
            myCurrentDate = UILabel(frame: CGRect(x: 10, y: 150, width: view.bounds.width, height: 40))
            myCurrentDate.font = UIFont(name: "ArialMT", size: 40)
            myCurrentDate.textColor = .white
            myCurrentDate.numberOfLines = 0
            myCurrentDate.textAlignment = .center


            
            self.view.addSubview(myCurrentTemp)
            self.view.addSubview(myCurrentPrecipitation)
            self.view.addSubview(myCurrentWind)
            self.view.addSubview(myCurrentDate)


        }
        
        func setupTextField() {
            
            myTextFieldTemperature.becomeFirstResponder()
            
            myTextFieldTemperature = UITextField(frame: CGRect(x: 70, y: 100, width: self.view.bounds.width / 2 + 30, height: 40))
            myTextFieldTemperature.backgroundColor = .white
            myTextFieldTemperature.placeholder = "Placeholder"
            myTextFieldTemperature.layer.cornerRadius = 10
            myTextFieldTemperature.layer.opacity = 0.5
            view.addSubview(myTextFieldTemperature)

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
        return forecastWeatherDay.count != 0 ? forecastWeatherDay.count: 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        if forecastWeatherDay.count != 0{
            
            cell.myHour.text = "\(forecastDate[indexPath.row]) hour"
            cell.myTemp.text = "\(forecastWeatherDay[indexPath.row]) ℃"
            cell.myRain.text = "\(forecastRain[indexPath.row])  mm"
            cell.myWindSpeed.text = "\(forecastWindSpeed[indexPath.row])  m/s"
            cell.myImage.image = UIImage(named: myIconWeather[indexPath.row])
        } else {
            cell.myTemp.text = "Not forecast"
        }
        
        return cell
    }
    
    
}




    
    
    
    

    



