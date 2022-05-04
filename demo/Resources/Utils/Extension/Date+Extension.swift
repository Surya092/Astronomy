//
//  Date+Extension.swift
//  demo
//
//  Created by Surya on 04/05/22.
//

import Foundation

extension Date {
    static func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: Date())
    }
}
