//
//  TimeModalConvert.swift
//  MyForecast
//
//  Created by Evgenii Kutasov on 04.07.2023.
//

import Foundation

struct TimeModalConvert {
    func modelDateFormat(StringDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        guard let date = inputFormatter.date(from: StringDate) else { return "" }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM HH:mm"
        let formattedDate = outputFormatter.string(from: date)
        return formattedDate
    }
}
