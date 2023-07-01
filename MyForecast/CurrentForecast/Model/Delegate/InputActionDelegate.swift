//
//  ButtonAction.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 18.06.2023.
//

import Foundation
import UIKit

protocol InputActionDelegate: ViewController {
    func didPressSearchButton(city: String, day: Int)
}
