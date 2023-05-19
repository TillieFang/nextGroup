//
//  LibraryRoom.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation

struct LibraryRoom {
    let buildingNumber : String //B02
    let buildingLevel : String //06
    let roomNumber: String //123
    let capacity: Int //1
    let roomType: String // Group Study Room
    let facilities: String // 1 monitor / Charger .. etc
    let buildingIdentifier: String
}

var rooms : [LibraryRoom] = [
    LibraryRoom(buildingNumber: "02", buildingLevel: "04", roomNumber: "163", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor", buildingIdentifier: "02"),
    LibraryRoom(buildingNumber: "02", buildingLevel: "04", roomNumber: "165", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor", buildingIdentifier: "02"),
    LibraryRoom(buildingNumber: "02", buildingLevel: "04", roomNumber: "167", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor", buildingIdentifier: "02"),
    LibraryRoom(buildingNumber: "06", buildingLevel: "04", roomNumber: "165", capacity: 4,  roomType: "Group Study Room", facilities: "1 Monitor", buildingIdentifier: "02"),
    LibraryRoom(buildingNumber: "07", buildingLevel: "04", roomNumber: "163", capacity: 4, roomType: "Group Study Room", facilities: "1 Monitor", buildingIdentifier: "02"),
    LibraryRoom(buildingNumber: "11", buildingLevel: "04", roomNumber: "165", capacity: 4,  roomType: "Group Study Room", facilities: "1 Monitor", buildingIdentifier: "11")
]
