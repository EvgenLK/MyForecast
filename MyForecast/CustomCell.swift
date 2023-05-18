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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myTemp)
        addSubview(myHour)
        

        
        myHour.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            myHour.topAnchor.constraint(equalTo: topAnchor),
            myHour.leadingAnchor.constraint(equalTo: leadingAnchor),
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
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
