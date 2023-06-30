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
            myWindSpeed.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            myWindSpeed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myWindSpeed.trailingAnchor.constraint(equalTo: trailingAnchor),
            myWindSpeed.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: topAnchor, constant: -35),
            myImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            myImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
            myImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65)
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
    let myImage: UIImageView = {
        let myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        return myImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImage)
        addSubview(myTemp)
        addSubview(myHour)
        addSubview(myRain)
        addSubview(myWindSpeed)
        setupConstraints()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
