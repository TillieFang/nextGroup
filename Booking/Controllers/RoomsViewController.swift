//
//  RoomsViewController.swift
//  Booking
//
//  Created by Ting on 2023/5/10.
//

import UIKit

struct roomInfo {
    var roomNumber : String
    var capacity : Int
    var index: Int
}

class RoomsViewController: UIViewController {

    
    // RoomView outlet connections
    @IBOutlet weak var buildingDateLabel: UILabel!
    @IBOutlet weak var timeDurationTextField: UITextField!
    @IBOutlet weak var timeDurationStepper: UIStepper!
    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var startingTimeDatePicker: UIDatePicker!
    @IBOutlet weak var bookingButton: UIButton!
    
    // Variable to hold the rooms information
    var roomsTableData : [roomInfo] = []
        
    // Variables getting the values of current view
    var stepperValue: Int = 30
    var selectedIndex : IndexPath?
    var buildingRooms: [RoomDetails] = []
    var roomSelected: Int = 0

    // Variable from the previous window
    var building: String? = nil
    var bookingDate: Date? = nil
    var starTime: Date? = nil
    var userEmail: String? = nil

    // Set up the view, disabling the booking button until a room is selected and configuring the booking timezone
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookingButton.isEnabled = false
        
        buildingDateLabel.text = "\(building ?? ErrorHandler().showErrorMessage(errorID: 1))/\(DateTimeHandler().formatDate(date: bookingDate))"
        
        
        buildingRooms = BookingDataHandler().getBuildingRooms(building: building!)

        // Timezone configuration
        startingTimeDatePicker.locale = Locale(identifier: "en_AU")
        startingTimeDatePicker.timeZone = TimeZone(abbreviation: "Australia/Sydney")
        startingTimeDatePicker.minimumDate = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())
        startingTimeDatePicker.maximumDate = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())
        
        starTime = startingTimeDatePicker.date

        populateAvailableRooms()
    }
    
    // Function to check the rooms available and refresh the TableView
    func populateAvailableRooms() {
        
        roomsTableData = []
        
        for (index, room) in buildingRooms.enumerated() {
            
            // Check if the room slots are available during the selected time or not, refresh each time the time is changed
            if !BookingDataHandler().isRoomAvailable(room: room.roomNumber, date: bookingDate!, time: starTime!, length: stepperValue) {
                continue
            }
            
            let newRoom : roomInfo = roomInfo(roomNumber: room.roomNumber, capacity: room.capacity, index: index)
            roomsTableData.append(newRoom)
        }
        roomsTableView.reloadData()
    }
    
    
    // Update the start date based on the View input
    @IBAction func startTimeChanged(_ sender: UIDatePicker) {
        starTime = sender.date
        populateAvailableRooms()
    }
    
    // Set the reservation duration based on the stepper value
    @IBAction func stepperTapped(_ sender: UIStepper) {
        stepperValue = Int(sender.value)
        timeDurationTextField.text = DateTimeHandler().formatBookingTime(timeValue: stepperValue)
        populateAvailableRooms()
    }
    
    // Prepare and send the information to the confirmation view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConfirm" {
            let confirmViewController = segue.destination as! ConfirmViewController

            confirmViewController.roomToBook = buildingRooms[roomSelected].roomNumber
            confirmViewController.userEmail = userEmail
            confirmViewController.bookingDuration = stepperValue
            confirmViewController.roomBuilding = building
            
            confirmViewController.bookingTime = starTime
            confirmViewController.bookingDate = bookingDate
        }
    }
}

// Extension for the table view
extension RoomsViewController : UITableViewDelegate,UITableViewDataSource {
    
    // Return the tableview rows based on the rooms available
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsTableData.count
    }
    
    // Instantiate and return the TableView cell with the rooms information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomCell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath)
        let room = roomsTableData[indexPath.row]
        roomCell.textLabel?.text = room.roomNumber
        roomCell.detailTextLabel?.text = "Capacity: \(room.capacity)"
        return roomCell
    }
    
    // Stores the selected cell id to identify the room
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        roomSelected = roomsTableData[indexPath.row].index;
        bookingButton.isEnabled = true
    }
}
