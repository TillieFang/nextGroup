//
//  CustomMinutePickerView.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation
import UIKit

class CustomMinutePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    let minutes: [Int] = [0, 30] // Minute selection options: 0 and 30
    
    var selectedMinute: Int = 0 {
        didSet {
            // Action to take when minute value changes
            // E.g. display a selected minute value in a label or perform any necessary processing
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPickerView()
    }
    
    private func setupPickerView() {
        delegate = self
        dataSource = self
        selectedMinute = minutes.first ?? 0
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Show only 1 component (mins)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count // Returns the number of minutes select options
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(minutes[row])" // Returns the value of the minute select option as a string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMinute = minutes[row] // Save selected minute value
    }
    
    // MARK: - Custom method
    
    func setDate(_ date: Date) {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: date)
        
        // Find the closest available minute option
        var closestMinuteIndex = 0
        var closestMinuteDiff = Int.max
        for (index, option) in minutes.enumerated() {
            let diff = abs(option - minute)
            if diff < closestMinuteDiff {
                closestMinuteIndex = index
                closestMinuteDiff = diff
            }
        }
        
        // Select the closest minute option
        selectedMinute = minutes[closestMinuteIndex]
        selectRow(closestMinuteIndex, inComponent: 0, animated: true)
    }
}
