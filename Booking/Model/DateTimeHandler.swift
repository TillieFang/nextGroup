//
//  DateTimeHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 21/5/2023.
//

import Foundation

// Struct to handle data related to date/time and to format time values
struct DateTimeHandler {
    
    // Start a date formatter object to format the app content
    let dateFormatter: DateFormatter
    
    // Start the date formatter properties using Sydney as main location
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_AU")
        dateFormatter.timeZone = TimeZone(abbreviation: "Australia/Sydney")
    }
    
    // Function to format a date, returning it on format h:mm a
    func formatTime(date: Date?) -> String {
        guard let timeVal = date else {
            print(ErrorHandler().showErrorMessage(errorID: 8))
            return ""
        }
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timeVal)
    }
    
    // Function to format the booking duration into a string with hours and minutes
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
    
    // Function to format a date as a string with format EEEE, MMMM dd, yyyy
    func formatDate (date : Date?) -> String {
        guard let dateVal = date else {
            print(ErrorHandler().showErrorMessage(errorID: 9))
            return ""
        }
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return dateFormatter.string(from: dateVal)
    }
    
    // Function to format the date as a booking key format
    func formatDateAsKey (date: Date?) -> String {
        guard let dateVal = date else {
            print(ErrorHandler().showErrorMessage(errorID: 10))
            return ""
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dateVal)
    }
}
