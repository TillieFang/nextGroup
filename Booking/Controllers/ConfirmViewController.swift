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
    
    var roomToBook : String? = "";
    var roomBuilding : String? = "";
    var dateTimeRoom : String? = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        bookedRoomLabel.text = roomToBook;
        buildingLabel.text = roomBuilding;
        bookDateTimeLabel.text = dateTimeRoom;
    }

    @IBAction func returnToHomePage(_ sender: Any) {
        if let settingsVC = self.navigationController?.viewControllers[1] {
                    self.navigationController?.popToViewController(settingsVC, animated: true)
        }
    }
    
    @IBAction func returnToSelectRoom(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

