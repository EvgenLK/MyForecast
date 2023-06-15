//
//  ExtansionLocalizable.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 11.06.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
