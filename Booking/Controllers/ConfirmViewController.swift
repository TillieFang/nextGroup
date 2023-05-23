//
//  ConfirmViewController.swift
//  Booking
//
//  Created by Akshaya Mohanlal on 9/5/2023.
//

import Foundation
import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var bookedRoomLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var bookDateTimeLabel: UILabel!
    @IBOutlet weak var bookingDurationLabel: UILabel!
    
    var roomToBook: String? = nil
    var roomBuilding: String? = nil
    var bookingDate: Date? = nil
    var bookingTime: Date? = nil
    var bookingDuration: Int? = nil
    var bookingName: String = ""
    var userEmail: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        bookedRoomLabel.text = roomToBook
        buildingLabel.text = roomBuilding
        bookDateTimeLabel.text = DateTimeHandler().formatDate(date: bookingDate)
        bookingDurationLabel.text = "\(DateTimeHandler().formatTime(date: bookingTime)) - \(DateTimeHandler().formatBookingTime(timeValue: bookingDuration!))"
        
        print("Got user email as \(userEmail ?? "NULL!")")
    }

    @IBAction func returnToHomePage(_ sender: Any) {
        
        /*
        guard roomToBook == nil, bookingDate == nil, bookingTime == nil , userEmail == nil else {
            ErrorHandler().showErrorMessage(errorID: 5)
            return
        }
        */
        
        // Add guard checks and warnings if any value is missinh
        guard let roomVal = roomToBook else {
            ErrorHandler().showErrorMessage(errorID: 8)
            return
        }
        guard let dateVal = bookingDate else {
            ErrorHandler().showErrorMessage(errorID: 9)
            return
        }
        guard let timeVal = bookingTime else {
            ErrorHandler().showErrorMessage(errorID: 10)
            return
        }
        guard let durationVal = bookingDuration else {
            ErrorHandler().showErrorMessage(errorID: 11)
            return
        }
        guard let emailVal = userEmail else {
            ErrorHandler().showErrorMessage(errorID: 12)
            return
        }

        BookingDataHandler().bookRoom(room: roomVal, date: dateVal, time: timeVal, length: durationVal, bookingName: bookingName, userEmail: emailVal)
        
//        if let settingsVC = self.navigationController?.viewControllers[1] {
//                    self.navigationController?.popToViewController(settingsVC, animated: true)
//        }
        let mybookingsVC = storyboard?.instantiateViewController(withIdentifier: "ManageBookingViewController") as! ManageBookingViewController
        self.navigationController?.pushViewController(mybookingsVC, animated: true)
        mybookingsVC.userEmail = userEmail
//        mybookingsVC.navigationItem.setHidesBackButton(true, animated: true)
     }
    
    @IBAction func returnToSelectRoom(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

