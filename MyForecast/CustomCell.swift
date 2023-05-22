//
//  CustomCell.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.05.2023.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    let myTemp = UILabel()
    let myHour = UILabel()
    let myRain = UILabel()
    let myWindSpeed = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myTemp)
        addSubview(myHour)
        addSubview(myRain)
        addSubview(myWindSpeed)
        
        myHour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            myHour.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            myHour.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myHour.trailingAnchor.constraint(equalTo: trailingAnchor),
            myHour.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        myTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            myTemp.topAnchor.constraint(equalTo: topAnchor),
            myTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myTemp.trailingAnchor.constraint(equalTo: trailingAnchor),
            myTemp.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
        myRain.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            myRain.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            myRain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myRain.trailingAnchor.constraint(equalTo: trailingAnchor),
            myRain.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        myWindSpeed.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            myWindSpeed.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            myWindSpeed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myWindSpeed.trailingAnchor.constraint(equalTo: trailingAnchor),
            myWindSpeed.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
