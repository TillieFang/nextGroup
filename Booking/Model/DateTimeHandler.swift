//
//  DateTimeHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 21/5/2023.
//

import Foundation

struct DateTimeHandler {
    
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_AU")
        dateFormatter.timeZone = TimeZone(abbreviation: "Australia/Sydney")
    }
    
    func formatTime(date: Date?) -> String {
        guard let timeVal = date else {
            ErrorHandler().showErrorMessage(errorID: 4)
            return ""
        }
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timeVal)
    }
    
    func formatBookingTime(timeValue:Int) -> String{
        let hour = Int(timeValue / 60)
        let minute = String(timeValue % 60)
        if hour == 0 {
            let formattedTime = String("\(minute) min")
            return formattedTime
        } else {
            let formattedTime = String("\(hour) hr  \(minute) min")
            return formattedTime
        }
    }
    
    func formatDate (date : Date?) -> String {
        guard let dateVal = date else {
            ErrorHandler().showErrorMessage(errorID: 4)
            return ""
        }
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return dateFormatter.string(from: dateVal)
    }
    
    func formatDateAsKey (date: Date?) -> String {
        guard let dateVal = date else {
            ErrorHandler().showErrorMessage(errorID: 4)
            return ""
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateVal)
    }
}
