//
//  DateFormatter + ddMMMMyyyy.swift
//  NoticeBoard
//
//  Created by Zhora Agadzhanyan on 27.08.2023.
//

import Foundation

extension DateFormatter {
    static var ddMMMMyyyy: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        return formatter
    }
}
