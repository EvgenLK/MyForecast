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
    let myButtonTemperature = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackGround()
        setupTextField() 
        setupLabel()
        self.title = "My Forest Weather"
    }
    
    func setupLabel() {
        
        

        
        myLabelTemperature = UILabel(frame: CGRect(x: 150, y: 200, width: 200, height: 100))
        myLabelTemperature.font = UIFont.systemFont(ofSize: 50)
        myLabelTemperature.textColor = .white
        myLabelTemperature.text = "Hello"

        
        self.view.addSubview(myLabelTemperature)
    }
    
    func setupTextField() {
        
        myTextFieldTemperature = UITextField(frame: CGRect(x: 80, y: 100, width: self.view.bounds.width / 2 + 30, height: 40))
        myTextFieldTemperature.backgroundColor = .white
        myTextFieldTemperature.placeholder = "placeholder"
        myTextFieldTemperature.layer.cornerRadius = 10
        myTextFieldTemperature.layer.opacity = 0.5
        
        view.addSubview(myTextFieldTemperature)
    }
    
    
    func setupBackGround() {
        backGroundImage.image = UIImage(named: "GoodDay.jpg")
        backGroundImage.contentMode = .scaleAspectFill
        
        view.addSubview(backGroundImage)
        
    }
    

}

