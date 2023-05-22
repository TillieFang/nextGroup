//
//  BuildingHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 20/5/2023.
//

import Foundation

struct bookedHour: Codable{
    var bookingDate: String
    var bookingHour: String
    var bookedRoom: String
    var bookingName: String
    var userEmail: String
}

struct bookedEmail: Codable {
    var bookedHours: [bookedHour]
}

struct BookingDataHandler {
    
    func getBuildingRooms(building: String) -> [RoomDetails] {
        var rooms : [RoomDetails] = []
        
        switch(building) {
        case "Building 02":
            rooms = roomsBuilding02
            break
        case "Building 06":
            rooms = roomsBuilding06
            break
        case "Building 07":
            rooms = roomsBuilding07
            break
        case "Building 11":
            rooms = roomsBuilding11
            break
        default:
            break
        }
        
        return rooms;
    }
    
    func getRoomBookingSlots(key: String)-> [bookedHour] {
        
        let defaults = UserDefaults.standard;
        if let storedBookingSlots = defaults.value(forKey: key) as? Data {
            if let bookingSlotsArray = try? PropertyListDecoder().decode(Array<bookedHour>.self, from: storedBookingSlots) {
                return bookingSlotsArray
            }
        }
        return []
    }
    
    func getUserBookings(email: String) -> [String] {
        
        let defaults = UserDefaults.standard
        if let storedUserBookings = defaults.value(forKey: email) as? Data {
            if let userBookingsArray = try? PropertyListDecoder().decode(Array<String>.self, from: storedUserBookings) {
                return userBookingsArray
            }
        }
        return []
    }
    
    func bookRoom(room: String, date: Date, time: Date, length: Int, bookingName: String, userEmail: String) {
                        
        print("Trying to book the room \(room), date \(date) at \(time) for \(length) mins")
        
        let bookingKey = formatStorageData(room: room, date: date)

        print("Calling booking room with key \(bookingKey)")

        var roomBookingSlots: [bookedHour] = getRoomBookingSlots(key: bookingKey)
        print("Got room booking info \(roomBookingSlots)")
        
        // Split booking into 30 mins slots
        
        var roomBooking : [bookedHour] = convertBookingToBookedHour(bookedRoom: room, date: date, time: time, length: length, bookingName: bookingName, userEmail: userEmail)
        
        for booking in roomBooking {
            roomBookingSlots.append(booking)
        }
        
        var userBookingKeys = getUserBookings(email: userEmail)
        print("Got User Bookings \(userBookingKeys)")

        userBookingKeys.append(bookingKey)

        let defaults = UserDefaults.standard

        // Store the booking information by room and date
        defaults.set(try? PropertyListEncoder().encode(roomBookingSlots), forKey: bookingKey)
        
        // Associate and store the booking date with the email to edit later
        defaults.set(try? PropertyListEncoder().encode(userBookingKeys), forKey: userEmail)
                
    }
    
    func isRoomAvailable(room: String, date: Date, time: Date, length: Int)-> Bool {
        
        var isAvailable = true
        var bookingTimes: [String] = []
        
        let bookingKey = formatStorageData(room: room, date: date)
        let roomBookingSlots: [bookedHour] = getRoomBookingSlots(key: bookingKey)
        
        for timeSlot in stride(from: 0, to: length, by: 30) {
            bookingTimes.append(DateTimeHandler().formatTime(date: time.addingTimeInterval(Double(timeSlot) * 60)))
        }
        
        for bookedSlot in roomBookingSlots {
            if bookingTimes.contains(bookedSlot.bookingHour) {
                isAvailable = false
                break
            }
        }

        return isAvailable
    }
    
    func formatStorageData(room: String, date: Date?) -> String {
        return "\(room)-\(DateTimeHandler().formatDateAsKey(date: date))"
    }
    
    func convertBookingToBookedHour (bookedRoom: String, date: Date, time: Date, length: Int, bookingName: String, userEmail: String) -> [bookedHour] {
        var bookings: [bookedHour] = []
                
        for timeSlot in stride(from: 0, to: length, by: 30) {
            let newSlot: bookedHour = bookedHour(bookingDate: DateTimeHandler().formatDate(date: date), bookingHour: DateTimeHandler().formatTime(date: time.addingTimeInterval(Double(timeSlot) * 60)), bookedRoom: bookedRoom, bookingName: bookingName, userEmail: userEmail)
            bookings.append(newSlot)
        }

        return bookings
    }
    
}