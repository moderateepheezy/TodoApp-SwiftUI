//
//  Date+Extension.swift
//  TodoApp
//
//  Created by Afees Lawal on 06/08/2020.
//

import Foundation

extension Date: Identifiable {
    public var id: Double {
        return self.timeIntervalSince1970
    }
}

extension Date {
    var day: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return DateFormatterPool.dayMonthYearFormatter.string(from: self)
        }
    }

    var isNowOrLaterToday: Bool {
        return Calendar.current.isDateInToday(self) && self >= Date()
    }

    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isTodayOrLater: Bool {
        return Calendar.current.isDateInToday(self) || self > Date()
    }

    var isPast: Bool {
        return self <= Date()
    }

    func add(_ component: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: component, value: value, to: self) ?? Date()
    }
}

enum DateFormatterPool {

    static var formatters: [String: DateFormatter] = [:]

    private static let queue = DispatchQueue(label: "formatter.pool")

    static func get(format: String, timezone: TimeZone = TimeZone.current) -> DateFormatter {
        return queue.sync {
            let code = timezone.identifier
            let identifier = format + code
            var formatter = formatters[identifier]
            if formatter == nil {
                formatter = DateFormatter()
                formatter!.dateFormat = format
                formatter!.timeZone = timezone
                let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
                formatter!.locale = enUSPOSIXLocale
                formatters[identifier] = formatter!
            }
            return formatter!
        }
    }

    static let dayMonthYearFormatter = DateFormatterPool.get(format: "dd MMM, yyyy")
    static let timeFormatter = DateFormatterPool.get(format: "hh:ss a")
}
