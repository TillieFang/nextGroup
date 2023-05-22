//
//  ManageBookingViewController.swift
//  Booking
//
//  Created by Ting on 2023/5/21.
//

import UIKit


class ManageBookingViewController : UIViewController{
    
    @IBOutlet weak var myBookingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func returnToHome(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}




