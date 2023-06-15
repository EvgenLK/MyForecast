//
//  CurentWeather.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 12.06.2023.
//

import Foundation
import UIKit
class CurentWeather: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(setupBackGround)
        addSubview(myTextFieldTemperature)
        addSubview(myTextFieldDaysForeCast)
        addSubview(myButtonTemperature)
        addSubview(myCurrentTemp)
        addSubview(myCurrentPrecipitation)
        addSubview(myCurrentWind)
        addSubview(myCurrentDate)
        setupСonstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let setupBackGround: UIImageView = {
        let setupBackGround = UIImageView()
        setupBackGround.image = UIImage(named: "GoodDay")
        setupBackGround.contentMode = .scaleAspectFill
        setupBackGround.frame = UIScreen.main.bounds
        return setupBackGround
    }()
    

    
    private let myButtonTemperature: UIButton = {
        var myButtonTemperature = UIButton()
        myButtonTemperature.layer.cornerRadius = 15
        myButtonTemperature.setTitle("searh_button".localized, for: .normal)
        myButtonTemperature.backgroundColor = .blue
        myButtonTemperature.setTitleColor(.systemBlue, for: .highlighted)
        myButtonTemperature.setTitle("searh_button".localized, for: .highlighted)
        myButtonTemperature.layer.borderWidth = 0.5
//        myButtonTemperature.addTarget(CurentWeather.self, action: #selector(requestForecastWeather), for: .touchUpInside)
        myButtonTemperature.translatesAutoresizingMaskIntoConstraints = false
        return myButtonTemperature
    }()
    
    private let myCurrentDate: UILabel = {
        let myCurrentDate = UILabel()
        myCurrentDate.font = UIFont(name: "ArialMT", size: 40)
        myCurrentDate.textColor = .white
        myCurrentDate.numberOfLines = 0
        myCurrentDate.textAlignment = .center
        myCurrentDate.translatesAutoresizingMaskIntoConstraints = false
        myCurrentDate.text = "21.07.2023"
        return myCurrentDate
    }()
    
    private let myCurrentTemp: UILabel = {
        let myCurrentTemp = UILabel()
        myCurrentTemp.font = UIFont(name: "ArialMT", size: 50)
        myCurrentTemp.textColor = .white
        myCurrentTemp.text = "current_temp_view".localized
        myCurrentTemp.numberOfLines = 0
        myCurrentTemp.textAlignment = .center
        myCurrentTemp.translatesAutoresizingMaskIntoConstraints = false
        myCurrentTemp.text = "20 Celsios"
        return myCurrentTemp
    }()
    
    private let myCurrentPrecipitation: UILabel = {
        let myCurrentPrecipitation = UILabel()
        myCurrentPrecipitation.font = UIFont(name: "ArialMT", size: 50)
        myCurrentPrecipitation.textColor = .white
        myCurrentPrecipitation.numberOfLines = 0
        myCurrentPrecipitation.textAlignment = .center
        myCurrentPrecipitation.translatesAutoresizingMaskIntoConstraints = false
        myCurrentPrecipitation.text = "0.3 mm"
        return myCurrentPrecipitation
    }()
    
    private let myCurrentWind: UILabel = {
        let myCurrentWind = UILabel()
        myCurrentWind.font = UIFont(name: "ArialMT", size: 50)
        myCurrentWind.textColor = .white
        myCurrentWind.numberOfLines = 0
        myCurrentWind.textAlignment = .center
        myCurrentWind.translatesAutoresizingMaskIntoConstraints = false
        myCurrentWind.text = "0.5 m/s"
        return myCurrentWind
    }()
    
    private let myTextFieldDaysForeCast: UITextField = {
        let myTextFieldDaysForeCast = UITextField()
        myTextFieldDaysForeCast.backgroundColor = .white
        myTextFieldDaysForeCast.placeholder = "placeholder_in_day_Forecast".localized
        myTextFieldDaysForeCast.layer.cornerRadius = 10
        myTextFieldDaysForeCast.layer.opacity = 0.5
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        myTextFieldDaysForeCast.leftView = indentView
        myTextFieldDaysForeCast.leftViewMode = .always
        myTextFieldDaysForeCast.translatesAutoresizingMaskIntoConstraints = false
        return myTextFieldDaysForeCast
    }()
    
    private let myTextFieldTemperature: UITextField = {
        let myTextFieldTemperature = UITextField()
        myTextFieldTemperature.backgroundColor = .white
        myTextFieldTemperature.placeholder = "placeholder_in_view".localized
        myTextFieldTemperature.layer.cornerRadius = 10
        myTextFieldTemperature.layer.opacity = 0.5
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        myTextFieldTemperature.leftView = indentView
        myTextFieldTemperature.leftViewMode = .always
        myTextFieldTemperature.translatesAutoresizingMaskIntoConstraints = false
        return myTextFieldTemperature
    }()
    
    func setupСonstraints() {
        NSLayoutConstraint.activate([
            myTextFieldTemperature.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            myTextFieldTemperature.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myTextFieldTemperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -170),
            myTextFieldTemperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -750),
        ])
        
        NSLayoutConstraint.activate([
            myTextFieldDaysForeCast.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            myTextFieldDaysForeCast.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myTextFieldDaysForeCast.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -170),
            myTextFieldDaysForeCast.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -690),
        ])
        
        NSLayoutConstraint.activate([
            myButtonTemperature.topAnchor.constraint(equalTo: topAnchor, constant: 90),
            myButtonTemperature.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 250),
            myButtonTemperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            myButtonTemperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -750),
        ])
        
        NSLayoutConstraint.activate([
            myCurrentDate.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            myCurrentDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myCurrentDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            myCurrentDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -600),
        ])
        
        NSLayoutConstraint.activate([
            myCurrentTemp.topAnchor.constraint(equalTo: topAnchor, constant: 190),
            myCurrentTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myCurrentTemp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            myCurrentTemp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -500),
        ])
        NSLayoutConstraint.activate([
            myCurrentPrecipitation.topAnchor.constraint(equalTo: topAnchor, constant: 220),
            myCurrentPrecipitation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myCurrentPrecipitation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            myCurrentPrecipitation.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -450),
        ])
        
        NSLayoutConstraint.activate([
            myCurrentWind.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            myCurrentWind.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            myCurrentWind.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            myCurrentWind.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -400),
        ])
        

    }
}
