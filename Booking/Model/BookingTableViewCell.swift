//
//  BookingTableViewCell.swift
//  Booking
//
//  Created by Andres Gonzalez on 22/5/2023.
//

import UIKit

// Class for the custom booking cell
class BookingTableViewCell: UITableViewCell {

    // Outlets linked to the cell labels
    @IBOutlet weak var bookingView: UIView!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bookingNameLabel: UILabel!
    
    // Variables needed to cancel the booking
    var bookingKey: String?
    var bookingReference: bookedHour?
    var viewControllerRef: ManageBookingViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Action called if the cancel button is pressed
    @IBAction func cancelBooking(_ sender: Any) {
        
        guard let bookingKeyVal = bookingKey, let bookingReferenceVal = bookingReference else {
            print(ErrorHandler().showErrorMessage(errorID: 7))
            return
        }
        
        BookingDataHandler().removeBooking(bookingKey: bookingKeyVal, bookingReference: bookingReferenceVal)
        
        viewControllerRef?.reloadTableView()
    }
}
