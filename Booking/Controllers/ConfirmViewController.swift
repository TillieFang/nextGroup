//
//  ConfirmViewController.swift
//  Booking
//
//  Created by Akshaya Mohanlal on 9/5/2023.
//

import Foundation
import UIKit

class ConfirmViewController: UIViewController {

    // Confirm view outlet connections
    @IBOutlet weak var bookedRoomLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var bookDateTimeLabel: UILabel!
    @IBOutlet weak var bookingDurationLabel: UILabel!
    
    // Variables to store and show the booking information
    var roomToBook: String? = nil
    var roomBuilding: String? = nil
    var bookingDate: Date? = nil
    var bookingTime: Date? = nil
    var bookingDuration: Int? = nil
    var bookingName: String = ""
    var userEmail: String? = nil
    
    // Add the upcoming variables to the label items
    override func viewDidLoad() {
        super.viewDidLoad()
                
        bookedRoomLabel.text = roomToBook
        buildingLabel.text = roomBuilding
        bookDateTimeLabel.text = DateTimeHandler().formatDate(date: bookingDate)
        bookingDurationLabel.text = "\(DateTimeHandler().formatTime(date: bookingTime)) - \(DateTimeHandler().formatBookingTime(timeValue: bookingDuration!))"        
    }

    // Button to book the room and go to the manage booking page
    @IBAction func returnToHomePage(_ sender: Any) {
        
        // Add guard checks and warnings if any value is missinh
        guard let roomVal = roomToBook else {
            print(ErrorHandler().showErrorMessage(errorID: 2))
            return
        }
        guard let dateVal = bookingDate else {
            print(ErrorHandler().showErrorMessage(errorID: 3))
            return
        }
        guard let timeVal = bookingTime else {
            print(ErrorHandler().showErrorMessage(errorID: 4))
            return
        }
        guard let durationVal = bookingDuration else {
            print(ErrorHandler().showErrorMessage(errorID: 5))
            return
        }
        guard let emailVal = userEmail else {
            print(ErrorHandler().showErrorMessage(errorID: 6))
            return
        }

        BookingDataHandler().bookRoom(room: roomVal, date: dateVal, time: timeVal, length: durationVal, bookingName: bookingName, userEmail: emailVal)
        
        let mybookingsVC = storyboard?.instantiateViewController(withIdentifier: "ManageBookingViewController") as! ManageBookingViewController
        self.navigationController?.pushViewController(mybookingsVC, animated: true)
        mybookingsVC.userEmail = userEmail
     }
    
    // Action to return to the room selection view
    @IBAction func returnToSelectRoom(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

