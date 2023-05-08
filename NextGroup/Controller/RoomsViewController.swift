//
//  RoomsViewController.swift
//  NextGroup
//
//  Created by Ting on 2023/5/8.
//

import UIKit

class RoomsViewController: UIViewController {

    @IBOutlet weak var timeDurationTextField: UITextField!
    
    @IBOutlet weak var timeDurationStepper: UIStepper!
    
    
    var timeDuration = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        var stepperValue = Int(sender.value)
        timeDurationTextField.text = formatTime(timeValue: stepperValue)
    }
    
    func formatTime(timeValue:Int) -> String{
        var hour = Int(timeValue / 60)
        var minute = String(timeValue % 60)
        if hour == 0 {
            let formattedTime = String("\(minute) min")
            return formattedTime
        } else {
            let formattedTime = String("\(hour) hr  \(minute) min")
            return formattedTime
        }
        
    }
    


}
