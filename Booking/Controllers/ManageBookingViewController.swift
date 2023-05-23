//
//  ManageBookingViewController.swift
//  Booking
//
//  Created by Ting on 2023/5/21.
//

import UIKit

class ManageBookingViewController : UIViewController{
        
    @IBOutlet weak var bookingsTableView: UITableView!
    var bookingsTableData : [bookedHour] = [] //bookedEmail
    var bookingsTableDataKey: [String] = []
    var userBookings: [String] = []
    var userEmail : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        guard let email = userEmail else {
            ErrorHandler().showErrorMessage(errorID: 12)
            return
        }
                
        updateBookings(email: email)
        
        print("User bookings \(bookingsTableData)")
        
        bookingsTableView.delegate = self
        bookingsTableView.dataSource = self
    }
        
    @IBAction func returnToHome(_ sender: Any) {
        if let settingsVC = self.navigationController?.viewControllers[1] {
            let settingsVCD = settingsVC as! SettingsViewController
            settingsVCD.userEmail = userEmail
            self.navigationController?.popToViewController(settingsVC, animated: true)
        }
    }
    
    
    func updateBookings(email: String) {

        bookingsTableData = []
        bookingsTableDataKey = []

        userBookings = BookingDataHandler().getUserBookings(email: email)
        
        print("User bookings keys \(userBookings) with email \(email) userEmail \(userEmail)")
        
        for booking in userBookings {
            let bookedSlotsWithKey = BookingDataHandler().getRoomBookingSlots(key: booking)
            
            for bookedSlot in bookedSlotsWithKey {
                let bookingExist = bookingsTableData.contains{ booking in
                    if booking == bookedSlot {
                        return true
                    }
                    else {
                        return false
                    }
                }
                
                if bookingExist {
                    continue
                }
                    
                if bookedSlot.userEmail == userEmail, bookedSlot.isStartingHour == true {
                    bookingsTableData.append(bookedSlot)
                    bookingsTableDataKey.append(booking)
                    break
                }
            }
        }
    }
    
    func reloadTableView() {
        updateBookings(email: userEmail!)
        
        print ("Should reload data with val \(userBookings) tableData \(bookingsTableData)!!")

        bookingsTableView.reloadData()
    }
}

extension ManageBookingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookingCell = tableView.dequeueReusableCell(withIdentifier: "bookingCell", for: indexPath) as! BookingTableViewCell
        let booking = bookingsTableData[indexPath.row]
        bookingCell.roomNumberLabel?.text = booking.bookedRoom
        bookingCell.locationLabel?.text = booking.bookingDate
        bookingCell.timeLabel?.text = booking.bookingHour
        bookingCell.bookingNameLabel?.text = "Duration: \(DateTimeHandler().formatBookingTime(timeValue: booking.duration))"
        bookingCell.bookingReference = booking
        bookingCell.bookingKey = bookingsTableDataKey[indexPath.row]
        bookingCell.viewControllerRef = self
        return bookingCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingsTableData.count
    }
}
