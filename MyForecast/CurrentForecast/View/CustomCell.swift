//
//  CustomCell.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.05.2023.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    let myTemp: UILabel = {
        let myTemp = UILabel()
        myTemp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTemp.topAnchor.constraint(equalTo: myTemp.topAnchor),
            myTemp.leadingAnchor.constraint(equalTo: myTemp.leadingAnchor, constant: 10),
            myTemp.trailingAnchor.constraint(equalTo: myTemp.trailingAnchor),
            myTemp.bottomAnchor.constraint(equalTo: myTemp.bottomAnchor)
        ])
        return myTemp
    }()
    
    let myHour: UILabel = {
        let myHour = UILabel()
        myHour.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myHour.topAnchor.constraint(equalTo: myHour.topAnchor, constant: -35),
            myHour.leadingAnchor.constraint(equalTo: myHour.leadingAnchor, constant: 10),
            myHour.trailingAnchor.constraint(equalTo: myHour.trailingAnchor, constant: 10),
            myHour.bottomAnchor.constraint(equalTo: myHour.bottomAnchor)
        ])
        return myHour
    }()
    
    let myRain: UILabel = {
        let myRain = UILabel()
        myRain.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myRain.topAnchor.constraint(equalTo: myRain.topAnchor, constant: 30),
            myRain.leadingAnchor.constraint(equalTo: myRain.leadingAnchor, constant: 10),
            myRain.trailingAnchor.constraint(equalTo: myRain.trailingAnchor),
            myRain.bottomAnchor.constraint(equalTo: myRain.bottomAnchor)
        ])
        return myRain
    }()
    
    let myWindSpeed: UILabel = {
        let myWindSpeed = UILabel()
        myWindSpeed.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myWindSpeed.topAnchor.constraint(equalTo: myWindSpeed.topAnchor, constant: 60),
            myWindSpeed.leadingAnchor.constraint(equalTo: myWindSpeed.leadingAnchor, constant: 10),
            myWindSpeed.trailingAnchor.constraint(equalTo: myWindSpeed.trailingAnchor),
            myWindSpeed.bottomAnchor.constraint(equalTo: myWindSpeed.bottomAnchor)
        ])
        return myWindSpeed
    }()
    let myImage = UIImageView() // позже доделаю
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myTemp)
        addSubview(myHour)
        addSubview(myRain)
        addSubview(myWindSpeed)
        addSubview(myImage)

        myImage.frame = CGRect(x: 5, y: -40, width: 50, height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weather: ModelDataWeather) {
        myHour.text = weather.time
        myTemp.text = String(weather.temperature_2m)
        myRain.text = String(weather.precipitation)
        myWindSpeed.text = String(weather.windspeed_10m)
        myImage.image = weather.imageIcon
    }
    
}
