//
//  SettingsViewController.swift
//  Booking
//
//  Created by Akshaya Mohanlal on 9/5/2023.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var buildingPopUpButton: UIButton!
    
    @IBOutlet weak var datePickerTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var manageBookingsButton: UIButton!

    var userEmail: String? = nil
    var bookingDate: Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable the continue button initially
        continueButton.isEnabled = false
        
        setPopUpButton()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 225)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        bookingDate = datePicker.date
        
        if let maximumDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) {
            datePicker.maximumDate = maximumDate }
        
       //to show done button
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 35))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
            toolbar.setItems([flexSpace, doneButton], animated: false)
    
        datePickerTextField.inputView = datePicker
        datePickerTextField.inputAccessoryView = toolbar
        datePickerTextField.text = DateTimeHandler().formatDate(date: Date())
        
    }
    
    //to make pop up for buildings
    func setPopUpButton(){
        
        let optionClosure = {(action : UIAction) in
            
            // Only process the action if the title is not "Buildings"
            // Enable the continue button when a building is selected
            if action.title != "Buildings" {
                print(action.title)
                self.continueButton.isEnabled = true
            }
        }
        
        buildingPopUpButton.menu = UIMenu(children : [
            UIAction(title : "Buildings", state: .on, handler : optionClosure),
            UIAction(title : "Building 02", handler : optionClosure),
            UIAction(title : "Building 06", handler : optionClosure),
            UIAction(title : "Building 07", handler : optionClosure),
            UIAction(title : "Building 11", handler : optionClosure)])
        
        buildingPopUpButton.showsMenuAsPrimaryAction = true
        buildingPopUpButton.changesSelectionAsPrimaryAction = true
    
    }
    
    @objc func dateChange (datePicker: UIDatePicker){
        bookingDate = datePicker.date
        datePickerTextField.text = DateTimeHandler().formatDate(date: bookingDate)
    }
    
    @objc func datePickerDone() {
        datePickerTextField.resignFirstResponder()
    }

    // create override func to passing the value
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRoom" {
            let roomsViewController = segue.destination as! RoomsViewController;
            roomsViewController.building = buildingPopUpButton.currentTitle
            roomsViewController.bookingDate = bookingDate
            roomsViewController.userEmail = userEmail
        }
    }
}
