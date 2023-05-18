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

        let urlString = "https://api.open-meteo.com/v1/gfs?latitude=43.11&longitude=131.87&hourly=temperature_2m,precipitation,windspeed_10m&forecast_days=1&timezone=auto"
        
        guard let url = URL(string: urlString) else {fatalError("fail")}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeaterData.self, from: data) {
                
                self.queue.async(flags: .barrier ){
                    for elem in 0..<23{
                        guard let temp = weather.hourly?.temperature2M![elem] else {return}
                        self.forecastWeatherDay.append(String(temp))
                        self.myLabelTemperature.text = "\(String(temp))" + "℃"
                    }
                }
            } else {
                    print("Fail")
                }
        }
            task.resume()

        }
    

        func setupLabel() {
            
            myLabelTemperature = UILabel(frame: CGRect(x: 10, y: 200, width: view.bounds.width, height: 100))
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
            backGroundImage.image = UIImage(named: "GoodDay.jpg")
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
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        
        cell.myTemp.text = forecastWeatherDay[indexPath.row]
        cell.myTemp.text = "text"
        
        
        return cell
    }
    
    
}




    
    
    
    

    



