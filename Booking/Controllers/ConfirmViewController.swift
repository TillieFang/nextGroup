//
//  ConfirmViewController.swift
//  Booking
//
//  Created by Akshaya Mohanlal on 9/5/2023.
//

import Foundation
import UIKit

class ConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

