//
//  ViewController.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 01.05.2023.
//

import UIKit

class ViewController: UIViewController {
    let ApiKeyForeCast = "63176e1a7b1b34c17e432ec30212b6f3"
    let backGroundImage = UIImageView(frame: UIScreen.main.bounds )
    var myLabelTemperature = UILabel()
    var myTextFieldTemperature = UITextField()
    var myButtonTemperature = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackGround()
        setupLabel()
        setupButtonTemp()
        self.title = "My Forest Weather"
        setupTextField()
        myTextFieldTemperature.addTarget(self, action: #selector(textFieldChange), for: .editingDidEnd)



    }
    
    
    func setupButtonTemp() {
        
        myButtonTemperature = UIButton(frame: CGRect(x: 310, y: 95, width: 100, height: 50))
        myButtonTemperature.layer.cornerRadius = 15
        

        myButtonTemperature.setTitle("Search", for: .normal)
        myButtonTemperature.backgroundColor = .systemBlue
        myButtonTemperature.addTarget(self, action: #selector(requestForecastWeather), for: .touchUpInside)

        myButtonTemperature.setTitle("Search", for: .highlighted)
        
        
        view.addSubview(myButtonTemperature)
        
    }
    
    
    @objc func requestForecastWeather() {
        
        myTextFieldTemperature.resignFirstResponder()

        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(myTextFieldTemperature.text!)&appid=\(ApiKeyForeCast)"
        
        guard let url = URL(string: urlString) else {fatalError("fail")}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    guard let temp = weather.main?.temp else {return}
                    self.myLabelTemperature.text = "\(Int(temp - 273.15))" + "℃"
                }
            } else {
                print("Fail")
            }
        }
            task.resume()
        }
    

        func setupLabel() {
            
            myLabelTemperature = UILabel(frame: CGRect(x: 100, y: 200, width: 250, height: 100))
            myLabelTemperature.font = UIFont(name: "ArialMT", size: 50)
            myLabelTemperature.textColor = .white
            myLabelTemperature.text = "25℃"
            myLabelTemperature.numberOfLines = 0
            myLabelTemperature.textAlignment = .center
            
            self.view.addSubview(myLabelTemperature)
        }
        
        func setupTextField() {
            
            myTextFieldTemperature.becomeFirstResponder()
            
            myTextFieldTemperature = UITextField(frame: CGRect(x: 80, y: 100, width: self.view.bounds.width / 2 + 30, height: 40))
            myTextFieldTemperature.backgroundColor = .white
            myTextFieldTemperature.placeholder = "Placeholder"
            myTextFieldTemperature.layer.cornerRadius = 10
            myTextFieldTemperature.layer.opacity = 0.5
            view.addSubview(myTextFieldTemperature)
            
        }
    
    @objc func textFieldChange() {
        
    }
        
        
        func setupBackGround() {
            backGroundImage.image = UIImage(named: "GoodDay.jpg")
            backGroundImage.contentMode = .scaleAspectFill
            
            view.addSubview(backGroundImage)
            
        }
      
}


    

