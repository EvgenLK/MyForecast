//
//  ConfigButton.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 03.05.2023.
//

import Foundation
import UIKit

class SetupButton {
    var myButtonTemperature = UIButton.Configuration.filled()
    myButtonTemperature.baseBackgroundColor = UIColor.systemBlue
    myButtonTemperature.buttonSize = .large
    
    let handler: UIButton.ConfigurationUpdateHandler = { button in
        switch button.state {
        case [.selected , .highlighted]:
            button.configuration?.title = "Highlighted Selected"
        case .selected:
            button.configuration?.title = "Selected"
        case .highlighted:
            button.configuration?.title = "Highlighted"
        case .disabled:
            button.configuration?.title = "Disabled"
        default:
            button.configuration?.title = "Normal"
        }
        
    }
    
    let button = UIButton(configuration: myButtonTemperature, primaryAction: nil)
    button.configurationUpdateHandler = handler
    
    let selectedButton = UIButton(configuration: myButtonTemperature, primaryAction: nil)
    selectedButton.isSelected = true
    selectedButton.configurationUpdateHandler = handler
    
    let disabledButton = UIButton(configuration: myButtonTemperature, primaryAction: nil)
    disabledButton.isEnabled = false
    disabledButton.configurationUpdateHandler = handler
    
    
}
