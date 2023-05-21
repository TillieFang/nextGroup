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
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "B02.04.163", capacity: 2,roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "B02.04.165", capacity: 4,roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "B02.04.167", capacity: 1,roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "B02.04.169", capacity: 2,roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "02", buildingLevel: "04", roomNumber: "B02.04.171", capacity: 6,roomType: "Group Study Room", facilities: "1 Monitor")
];

let roomsBuilding06 : [RoomDetails] = [
    RoomDetails(buildingNumber: "06", buildingLevel: "05", roomNumber: "B06.05.171", capacity: 1,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "06", buildingLevel: "05", roomNumber: "B06.05.173", capacity: 1,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "06", buildingLevel: "05", roomNumber: "B06.05.175", capacity: 3,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "06", buildingLevel: "05", roomNumber: "B06.05.177", capacity: 6,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "06", buildingLevel: "05", roomNumber: "B06.05.179", capacity: 8,  roomType: "Group Study Room", facilities: "1 Monitor")
];

let roomsBuilding07 : [RoomDetails] = [
    RoomDetails(buildingNumber: "07", buildingLevel: "08", roomNumber: "B07.08.182", capacity: 2, roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "07", buildingLevel: "08", roomNumber: "B07.08.184", capacity: 2, roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "07", buildingLevel: "08", roomNumber: "B07.08.186", capacity: 2, roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "07", buildingLevel: "08", roomNumber: "B07.08.188", capacity: 4, roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "07", buildingLevel: "08", roomNumber: "B07.08.190", capacity: 6, roomType: "Group Study Room", facilities: "1 Monitor")
];

let roomsBuilding11 : [RoomDetails] = [
    RoomDetails(buildingNumber: "11", buildingLevel: "10", roomNumber: "B11.10.130", capacity: 6,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "11", buildingLevel: "10", roomNumber: "B11.10.132", capacity: 8,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "11", buildingLevel: "10", roomNumber: "B11.10.134", capacity: 8,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "11", buildingLevel: "10", roomNumber: "B11.10.136", capacity: 10,  roomType: "Group Study Room", facilities: "1 Monitor"),
    RoomDetails(buildingNumber: "11", buildingLevel: "10", roomNumber: "B11.10.138", capacity: 4,  roomType: "Group Study Room", facilities: "1 Monitor")
];
