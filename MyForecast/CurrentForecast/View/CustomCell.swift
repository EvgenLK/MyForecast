//
//  CustomCell.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.05.2023.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    let updateWeather = CurentWeather()
    
    let myImage: UIImageView = {
        let myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        return myImage
    }()
    
    let myHour: UILabel = {
        let myHour = UILabel()
        myHour.translatesAutoresizingMaskIntoConstraints = false
        return myHour
    }()
    
    let myTemp: UILabel = {
        let myTemp = UILabel()
        myTemp.translatesAutoresizingMaskIntoConstraints = false
        return myTemp
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

    func setupConstraints() {
        let margins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: margins.topAnchor, constant: -40),
            myImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25),
            myImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -25),
            myImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -60)
        ])
        NSLayoutConstraint.activate([
            myHour.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: -30),
            myHour.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0),
            myHour.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0),
            myHour.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myTemp.topAnchor.constraint(equalTo: margins.topAnchor,constant: 10),
            myTemp.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25),
            myTemp.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -25),
            myTemp.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            myRain.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40),
            myRain.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25),
            myRain.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -25),
            myRain.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            myWindSpeed.topAnchor.constraint(equalTo: margins.topAnchor, constant: 60),
            myWindSpeed.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25),
            myWindSpeed.trailingAnchor.constraint(equalTo: margins.trailingAnchor,constant: -25),
            myWindSpeed.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 15)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImage)
        contentView.addSubview(myTemp)
        contentView.addSubview(myHour)
        contentView.addSubview(myRain)
        contentView.addSubview(myWindSpeed)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congifure(with weather: CustomCellViewModel) {
        
        myHour.text = weather.time
        myRain.text = weather.rain
        myTemp.text = weather.temp
        myWindSpeed.text = weather.windSpeed
        myImage.image = UIImage(named: weather.iconImage)
        
    }
}
