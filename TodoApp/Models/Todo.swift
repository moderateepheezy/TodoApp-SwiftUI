//
//  Todo.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import Foundation

struct Todo: Dated {
    var id = UUID()
    let title: String
    var isCompleted = false
    var isAlarmSet: Bool = false
    let category: Category
    let note: String
    let date: Date

    var time: String {
        DateFormatterPool.timeFormatter.string(from: date)
    }

    enum Category: String, CaseIterable {
        case personal = "Personal"
        case work = "Work"
        case meeting = "Meeting"
        case shopping = "Shopping"
        case party = "Party"
        case study = "Study"

        var imageName: String {
            return self.rawValue.lowercased()
        }
    }
}

extension Todo: Comparable {
    static func < (lhs: Todo, rhs: Todo) -> Bool {
        let lhsDueToday = lhs.date.isNowOrLaterToday
        let rhsDueToday = rhs.date.isNowOrLaterToday
        if lhsDueToday && !rhsDueToday {
            return true
        } else if !lhsDueToday && rhsDueToday {
            return false
        } else {
            return lhs.date < rhs.date
        }
    }
}
