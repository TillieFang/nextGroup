//
//  BuildingHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 20/5/2023.
//

import Foundation

struct BuildingDataHandler {
    
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
    
    func bookRoom(room: String, date: String, length: Int, bookingName: String) {
        let defaults = UserDefaults.standard
        
        // Split booking into 30 mins slots
        
        var roomBooking : String = ""
        
        defaults.set(try? PropertyListEncoder().encode(roomBooking), forKey: formatStorageData(room: room, date: date))
                
    }
    
    func isRoomReserved(building: String, room: String, date: String, length: Int)-> Bool {
        
        var isReserved = false
        let defaults = UserDefaults.standard
        
        if let storedRoomBookingData = defaults.value(forKey: formatStorageData(room: room, date: date)) as? Data {
            
        }
        
        return isReserved
    }
    
    func formatStorageData(room: String, date: String) -> String {
        return ""
    }
    
    
    
}
