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

        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(myTextFieldTemperature.text!.replacingOccurrences(of: " ", with: ""))&appid=\(ApiKeyForeCast)&units=metric"
        
        guard let url = URL(string: urlString) else {fatalError("fail")}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    guard let temp = weather.main?.temp else {return}
                    self.myLabelTemperature.text = "\(Int(temp))" + "℃"
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
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height/1.3),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])

        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        layout.scrollDirection = .horizontal
        return cv

    }()
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
        title.text = "text new"
        title.font = UIFont(name: "AvenirNext-Bold", size: 15)
        title.textAlignment = .center
        cell.contentView.addSubview(title)

        return cell
    }
    
    
}




    
    
    
    

    



