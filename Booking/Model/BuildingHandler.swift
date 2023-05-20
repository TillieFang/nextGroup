//
//  BuildingHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 20/5/2023.
//

import Foundation

struct BuildingHandler {
        
    func getBuildingRooms(building: String) -> [RoomDetails] {
        var rooms : [RoomDetails] = [];
        
        switch(building) {
        case "Building 02":
            rooms = roomsBuilding02;
            break;
        case "Building 06":
            rooms = roomsBuilding06;
            break;
        case "Building 07":
            rooms = roomsBuilding07;
            break;
        case "Building 11":
            rooms = roomsBuilding11;
            break;
        default:
            break;
        }
        
        return rooms;
    }
    
}
