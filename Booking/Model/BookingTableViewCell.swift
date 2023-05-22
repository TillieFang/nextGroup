//
//  BookingTableViewCell.swift
//  Booking
//
//  Created by Andres Gonzalez on 22/5/2023.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    @IBOutlet weak var bookingView: UIView!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bookingNameLabel: UILabel!
    
    var bookingKey: String?
    var bookingReference: bookedHour?
    var viewControllerRef: ManageBookingViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func cancelBooking(_ sender: Any) {
        
        guard let bookingKeyVal = bookingKey, let bookingReferenceVal = bookingReference else {
            ErrorHandler().showErrorMessage(errorID: 13)
            return
        }
        
        BookingDataHandler().removeBooking(bookingKey: bookingKeyVal, bookingReference: bookingReferenceVal)
        
        print ("Calling reload data on ref \(viewControllerRef)!!")

        viewControllerRef?.reloadTableView()
    }
}
