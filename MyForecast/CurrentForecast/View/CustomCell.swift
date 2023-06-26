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
        return myTemp
    }()
    func setupConstraints() {
        NSLayoutConstraint.activate([
            myTemp.topAnchor.constraint(equalTo: topAnchor),
            myTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myTemp.trailingAnchor.constraint(equalTo: trailingAnchor),
            myTemp.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myHour.topAnchor.constraint(equalTo: topAnchor, constant: -35),
            myHour.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myHour.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            myHour.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myRain.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            myRain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myRain.trailingAnchor.constraint(equalTo: trailingAnchor),
            myRain.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myWindSpeed.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            myWindSpeed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myWindSpeed.trailingAnchor.constraint(equalTo: trailingAnchor),
            myWindSpeed.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    let myHour: UILabel = {
        let myHour = UILabel()
        myHour.translatesAutoresizingMaskIntoConstraints = false
        return myHour
    }()
    
    let myRain: UILabel = {
        let myRain = UILabel()
        myRain.translatesAutoresizingMaskIntoConstraints = false
        return myRain
    }()
    
    let myWindSpeed: UILabel = {
        let myWindSpeed = UILabel()
        myWindSpeed.translatesAutoresizingMaskIntoConstraints = false
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
        setupConstraints()

        myImage.frame = CGRect(x: 5, y: -40, width: 50, height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weather: Hourly) {
        var timeString = ""
        for i in 0..<weather.time.count {
            timeString += "\(weather.time[i])\n"
        }
        myHour.text = timeString
        
        var tempString = ""
        for i in 0..<weather.temperature2M.count {
            tempString += "\(weather.temperature2M[i])\n"
        }
        myTemp.text = tempString
        
        var rainString = ""
        for i in 0..<weather.precipitation.count {
            rainString += "\(weather.precipitation[i])\n"
        }
        myRain.text = rainString
        
        var windspeedString = ""
        for i in 0..<weather.windspeed10M.count {
            windspeedString += "\(weather.windspeed10M[i])\n"
        }
        myWindSpeed.text = windspeedString
    }
}
