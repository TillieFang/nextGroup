//
//  ManageBookingViewController.swift
//  Booking
//
//  Created by Ting on 2023/5/21.
//

import UIKit

class ManageBookingViewController : UIViewController{
        
    // View controller reference and variables to show the booking data
    @IBOutlet weak var bookingsTableView: UITableView!
    var bookingsTableData : [bookedHour] = []
    var bookingsTableDataKey: [String] = []
    var userBookings: [String] = []
    var userEmail : String? = nil

    // check if the email is valid and update the bookings of that user email
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        guard let email = userEmail else {
            print(ErrorHandler().showErrorMessage(errorID: 6))
            return
        }
                
        updateBookings(email: email)
                
        bookingsTableView.delegate = self
        bookingsTableView.dataSource = self
    }
        
    // Action to return home
    @IBAction func returnToHome(_ sender: Any) {
        if let settingsVC = self.navigationController?.viewControllers[1] {
            let settingsVCD = settingsVC as! SettingsViewController
            settingsVCD.userEmail = userEmail
            self.navigationController?.popToViewController(settingsVC, animated: true)
        }
    }
    
    // Refresh the bookings associated to an email and add it to the table view data
    func updateBookings(email: String) {

        bookingsTableData = []
        bookingsTableDataKey = []

        userBookings = BookingDataHandler().getUserBookings(email: email)
                
        for booking in userBookings {
            let bookedSlotsWithKey = BookingDataHandler().getRoomBookingSlots(key: booking)
            
            // Loop through the booked slots and add it to the user if it's not duplicated
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
    
    // Reload the table view information
    func reloadTableView() {
        updateBookings(email: userEmail!)
        
        bookingsTableView.reloadData()
    }
}

// Extension to the table view
extension ManageBookingViewController : UITableViewDelegate, UITableViewDataSource {

    // Create the custom booking cell based on the number of bookings
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
    
    // return the number of rows based on the user bookings
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingsTableData.count
    }
}
