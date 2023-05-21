//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit

class ViewController: UIViewController {
    let backGroundImage = UIImageView(frame: UIScreen.main.bounds )
    var myLabelTemperature = UILabel()
    var myTextFieldTemperature = UITextField()
    var myButtonTemperature = UIButton()
    var forecastWeatherDay: [String] = []
    let queue = DispatchQueue(label: "thred-save-inArray", attributes: .concurrent)
    var arrayCityForecast: [String] = []
    var forecastRain: [String] = []
    var forecastWindSpeed: [String] = []
    var currentData: Int = {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
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
    
    func setupScrollView() {
        
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
        myLabelTemperature.text = "loading..."
        
        let urlCityString = "https://geocoding-api.open-meteo.com/v1/search?name=\(myTextFieldTemperature.text!.replacingOccurrences(of: " ", with: ""))&count=1&language=en&format=json"
        
        guard let urlcity = URL(string: urlCityString) else {fatalError("fail")}
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
        sleep(2)
        
        let urlString = "https://api.open-meteo.com/v1/gfs?latitude=\(arrayCityForecast[0])&longitude=\(arrayCityForecast[1])&hourly=temperature_2m,precipitation,windspeed_10m&windspeed_unit=ms&forecast_days=1&timezone=auto"
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeaterData.self, from: data) {
                self.forecastWeatherDay.removeAll()
                
                self.queue.async(flags: .barrier){ [weak self] in
                    for elem in 0..<24{
                        guard let temp = weather.hourly?.temperature2M![elem] else {return}
                        self?.forecastWeatherDay.append(String(Int(temp)))
                    }
                    self?.updateArrAsync()
                }
                
                self.queue.async(flags: .barrier){ [weak self] in
                    for elem in 0..<24{
                        guard let rain = weather.hourly?.precipitation![elem] else {return}
                        self?.forecastRain.append(String(Double(rain)))
                    }
                    self?.updateArrAsync()
                }
                self.queue.async(flags: .barrier){ [weak self] in
                    for elem in 0..<24{
                        guard let windSpeed = weather.hourly?.windspeed10M![elem] else {return}
                        self?.forecastWindSpeed.append(String(Double(windSpeed)))
                    }
                    self?.updateArrAsync()
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let temp = weather.hourly?.temperature2M![self!.currentData] else {return}
                    self?.myLabelTemperature.text = "\(Int(temp))" + "℃"

                }
            } else {
                print("Fail")
            }
        }

        task.resume()
    }
    
    func updateArrAsync() {
        DispatchQueue.main.async {
            _ = self.forecastWeatherDay
            _ = self.forecastRain
            _ = self.forecastWindSpeed
            self.collectionView.reloadData()
        }
    }
    func updateTupleAsync() {
        DispatchQueue.main.async {
            _ = self.arrayCityForecast

        }
    }


        func setupLabel() {
            
            myLabelTemperature = UILabel(frame: CGRect(x: 10, y: 170, width: view.bounds.width, height: 100))
            myLabelTemperature.font = UIFont(name: "ArialMT", size: 50)
            myLabelTemperature.textColor = .white
            myLabelTemperature.text = "Enter the city"
            myLabelTemperature.numberOfLines = 0
            myLabelTemperature.textAlignment = .center
            
            self.view.addSubview(myLabelTemperature)
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
            backGroundImage.image = UIImage(named: "GoodDay")
            backGroundImage.contentMode = .scaleAspectFill

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
            cell.myHour.text = "\(String(indexPath.row)) hour"
            cell.myTemp.text = "\(forecastWeatherDay[indexPath.row]) ℃"
            cell.myRain.text = "\(forecastRain[indexPath.row])  mm"
            cell.myWindSpeed.text = "\(forecastWindSpeed[indexPath.row])  m/s"
        } else {
            cell.myTemp.text = "Not forecast"
        }
        
        return cell
    }
    
    
}




    
    
    
    

    



