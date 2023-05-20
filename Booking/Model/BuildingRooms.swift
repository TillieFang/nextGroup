//
//  LibraryRoom.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation

struct RoomDetails {
    let buildingNumber : String //B02
    let buildingLevel : String //06
    let roomNumber: String //123
    let capacity: Int //1
    let roomType: String // Group Study Room
    let facilities: String // 1 monitor / Charger .. etc
}

let roomsBuilding02 : [RoomDetails] = [
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "B02.04.163", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "165", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "167", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor")
];

let roomsBuilding06 : [RoomDetails] = [
    RoomDetails(buildingNumber: "06", buildingLevel: "04", roomNumber: "165", capacity: 4,  roomType: "Group Study Room", facilities: "1 Monitor")
];

let roomsBuilding07 : [RoomDetails] = [
    RoomDetails(buildingNumber: "07", buildingLevel: "04", roomNumber: "163", capacity: 4, roomType: "Group Study Room", facilities: "1 Monitor")
];

let roomsBuilding11 : [RoomDetails] = [
    RoomDetails(buildingNumber: "11", buildingLevel: "04", roomNumber: "165", capacity: 4,  roomType: "Group Study Room", facilities: "1 Monitor")
];
