//
//  BuildingHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 20/5/2023.
//

import Foundation

// Struct to store a booking slot
struct bookedHour: Codable, Equatable{
    var bookingDate: String
    var bookingHour: String
    var bookedRoom: String
    var bookingName: String
    var userEmail: String
    var duration: Int
    var isStartingHour: Bool
}

// Struct to handle the saving and retrieving of bookings
struct BookingDataHandler {
    
    // Get the rooms associated with a building based on the building name
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
    
    // Retrieves the booked time slots associated to a key (room and date)
    func getRoomBookingSlots(key: String)-> [bookedHour] {
        
        let defaults = UserDefaults.standard;
        if let storedBookingSlots = defaults.value(forKey: key) as? Data {
            if let bookingSlotsArray = try? PropertyListDecoder().decode(Array<bookedHour>.self, from: storedBookingSlots) {
                return bookingSlotsArray
            }
        }
        return []
    }
    
    // Get the bookings linked to a user using its email
    func getUserBookings(email: String) -> [String] {
        
        let defaults = UserDefaults.standard
        if let storedUserBookings = defaults.value(forKey: email) as? Data {
            if let userBookingsArray = try? PropertyListDecoder().decode(Array<String>.self, from: storedUserBookings) {
                return userBookingsArray
            }
        }
        return []
    }
    
    // Function to book the room storing the user, location and time information
    func bookRoom(room: String, date: Date, time: Date, length: Int, bookingName: String, userEmail: String) {
                        
        let bookingKey = formatStorageData(room: room, date: date)

        var roomBookingSlots: [bookedHour] = getRoomBookingSlots(key: bookingKey) // Reset

        let roomBooking : [bookedHour] = convertBookingToBookedHour(bookedRoom: room, date: date, time: time, length: length, bookingName: bookingName, userEmail: userEmail) // Reset
        
        for booking in roomBooking {
            roomBookingSlots.append(booking)
        }
        
        var userBookingKeys: [String] = getUserBookings(email: userEmail) // Reset

        userBookingKeys.append(bookingKey) // Reset

        let defaults = UserDefaults.standard

        defaults.set(try? PropertyListEncoder().encode(roomBookingSlots), forKey: bookingKey)
        defaults.set(try? PropertyListEncoder().encode(userBookingKeys), forKey: userEmail)
    }
    
    // Function to remove a booking based on a booking key and a booking reference
    func removeBooking(bookingKey: String, bookingReference: bookedHour) {
        
        let defaults = UserDefaults.standard
        
        var bookingsWithKey = getRoomBookingSlots(key: bookingKey)

        var userBookingKeys: [String] = getUserBookings(email: bookingReference.userEmail)

        for (index, storedBookingKey) in userBookingKeys.enumerated() {
            if storedBookingKey == bookingKey {
                userBookingKeys.remove(at: index)
                break
            }
        }

        // Remove the booking and the upcoming bookings associated to it
        for _ in stride(from: 0, to: bookingReference.duration, by: 30) {
        innerloop: for (index, booking) in bookingsWithKey.enumerated() {
                if booking.bookingHour == bookingReference.bookingHour, booking.bookedRoom == bookingReference.bookedRoom, booking.userEmail == bookingReference.userEmail {
                    bookingsWithKey.remove(at: index)
                    break innerloop
                }
            }
        }
                
        // Store the booking information by room and date
        defaults.set(try? PropertyListEncoder().encode(bookingsWithKey), forKey: bookingKey)
        // Associate and store the booking date with the email to edit later
        defaults.set(try? PropertyListEncoder().encode(userBookingKeys), forKey: bookingReference.userEmail)
    }

    // Function to check if the room is available in a specific date and duration
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
    
    // Format the storage data to create a key
    func formatStorageData(room: String, date: Date?) -> String {
        return "\(room)-\(DateTimeHandler().formatDateAsKey(date: date))"
    }
    
    // Function to convert a booking information into a bookedHour object
    func convertBookingToBookedHour (bookedRoom: String, date: Date, time: Date, length: Int, bookingName: String, userEmail: String) -> [bookedHour] {
        var bookings: [bookedHour] = []
                
        for timeSlot in stride(from: 0, to: length, by: 30) {
            let newSlot: bookedHour = bookedHour(bookingDate: DateTimeHandler().formatDate(date: date), bookingHour: DateTimeHandler().formatTime(date: time.addingTimeInterval(Double(timeSlot) * 60)), bookedRoom: bookedRoom, bookingName: bookingName, userEmail: userEmail, duration: length, isStartingHour: timeSlot == 0 ? true : false)
            bookings.append(newSlot)
        }

        return bookings
    }
    
}
