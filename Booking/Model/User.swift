//
//  User.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation

struct User: Codable, Comparable {
    let buildingNumber: String
    let buildingLevel: String
    let roomNumber: String
    let selectedDate: String
    let fromTime: String
    let toTime: String
    var registerDate : Date = Date()

    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.registerDate < rhs.registerDate
    }
}
