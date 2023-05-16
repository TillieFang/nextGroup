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

    @IBOutlet weak var timeDurationTextField: UITextField!
    @IBOutlet weak var timeDurationStepper: UIStepper!
    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var startingTimeDatePicker: UIDatePicker!
    
    var roomsTableData : [roomInfo] = []
    
    var timeDuration = 0
    var selectedIndex : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        roomsTableData = [
            roomInfo(roomNumber: "room1", capacity: 1),
            roomInfo(roomNumber: "room2", capacity: 2),
            roomInfo(roomNumber: "room3", capacity: 3)]
        
    
    }
    
    
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        let stepperValue = Int(sender.value)
        timeDurationTextField.text = formatTime(timeValue: stepperValue)
    }
    
    
    func formatTime(timeValue:Int) -> String{
        let hour = Int(timeValue / 60)
        let minute = String(timeValue % 60)
        if hour == 0 {
            let formattedTime = String("\(minute) min")
            return formattedTime
        } else {
            let formattedTime = String("\(hour) hr  \(minute) min")
            return formattedTime
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
        roomCell.detailTextLabel?.text = "capacity: \(room.capacity)"
        return roomCell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath
//
//        tableView.beginUpdates()
//        tableView.reloadRows(at: [selectedIndex!], with: .none)
//        tableView.endUpdates()
//    }
}