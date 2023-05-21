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
}

class RoomsViewController: UIViewController {

    @IBOutlet weak var buildingDateLabel: UILabel!
    @IBOutlet weak var timeDurationTextField: UITextField!
    @IBOutlet weak var timeDurationStepper: UIStepper!
    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var startingTimeDatePicker: UIDatePicker!
    
    var roomsTableData : [roomInfo] = []
        
    var stepperValue: Int = 30
    var selectedIndex : IndexPath?
    // Variable from the previous window
    var building: String? = nil
    var bookingDate: Date? = nil
    var starTime: Date? = nil
    var userEmail: String? = nil

    var buildingRooms: [RoomDetails] = []
    var roomSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buildingDateLabel.text = "\(building ?? ErrorHandler().showErrorMessage(errorID: 3))/\(DateTimeHandler().formatDate(date: bookingDate))"
        
        
        buildingRooms = BookingDataHandler().getBuildingRooms(building: building!)

        startingTimeDatePicker.locale = Locale(identifier: "en_AU")
        startingTimeDatePicker.timeZone = TimeZone(abbreviation: "Australia/Sydney")
        startingTimeDatePicker.minimumDate = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())
        startingTimeDatePicker.maximumDate = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())
        
        print ("Picker initial value \(startingTimeDatePicker.date)")
        starTime = startingTimeDatePicker.date

        populateAvailableRooms()
    }
    
    
    func populateAvailableRooms() {
        
        roomsTableData = []
        
        let key = BookingDataHandler().formatStorageData(room: buildingRooms[roomSelected].roomNumber, date: bookingDate)
        print("Got booked rooms \(BookingDataHandler().getRoomBookingSlots(key: key)) with Key \(key)")

        for room in buildingRooms {
            
            // Check if the room slots are available during the selected time or not, refresh each time the time is changed
            if !BookingDataHandler().isRoomAvailable(room: room.roomNumber, date: bookingDate ?? Date.now, time: starTime ?? Date.now, length: stepperValue) {
                print("Room \(room.roomNumber) not available")
                continue
            }
            
            let newRoom : roomInfo = roomInfo(roomNumber: room.roomNumber, capacity: room.capacity)
            roomsTableData.append(newRoom)
        }
        roomsTableView.reloadData()
    }
    
    
    @IBAction func startTimeChanged(_ sender: UIDatePicker) {
        starTime = sender.date
        print("Date Picker \(DateTimeHandler().formatTime(date: sender.date))")
        populateAvailableRooms()
    }
    
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        stepperValue = Int(sender.value)
        timeDurationTextField.text = DateTimeHandler().formatBookingTime(timeValue: stepperValue)
        populateAvailableRooms()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToConfirm" {
            let confirmViewController = segue.destination as! ConfirmViewController
            confirmViewController.roomToBook = buildingRooms[roomSelected].roomNumber
            confirmViewController.userEmail = userEmail
            confirmViewController.bookingDuration = stepperValue
            confirmViewController.roomBuilding = building
            
            confirmViewController.bookingTime = starTime
            confirmViewController.bookingDate = bookingDate //"\(date ?? ErrorHandler().showErrorMessage(errorID: 1)) - \(timeDurationTextField.text ?? ErrorHandler().showErrorMessage(errorID: 2))"
        }
    }
}

extension RoomsViewController : UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if selectedIndex == indexPath {
//            return 200
//        }
//        return 60
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsTableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomCell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath)
        let room = roomsTableData[indexPath.row]
        roomCell.textLabel?.text = room.roomNumber
        roomCell.detailTextLabel?.text = "Capacity: \(room.capacity)"
        return roomCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        roomSelected = indexPath.row;
        
        /*
        if let viewController = storyboard?.instantiateViewController(identifier: "TrailViewController") as? TrailViewController {
            viewController.trail = selectedTrail
            navigationController?.pushViewController(viewController, animated: true)
        }
         */
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath
//
//        tableView.beginUpdates()
//        tableView.reloadRows(at: [selectedIndex!], with: .none)
//        tableView.endUpdates()
//    }
}
