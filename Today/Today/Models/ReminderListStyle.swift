//
//  ReminderListStyle.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 12/10/2023.
//

import Foundation

enum ReminderListStyle: Int {
    case today
    case future
    case all
    
    var name:String {
        switch self {
        case .today:
            return NSLocalizedString("Today", comment: "Today style name")
        case .future:
            return NSLocalizedString("Future", comment: "Future Style name")
        case .all:
            return NSLocalizedString("All", comment: "All style name")
        }
    }
    func shouldInclude(date:Date) -> Bool {
        let isinToday = Locale.current.calendar.isDateInToday(date)
        switch self {
        case .today:
            return isinToday
        case .future:
            return (date > Date.now) && !isinToday
        case .all:
            return true 
        }
    }
    
}
