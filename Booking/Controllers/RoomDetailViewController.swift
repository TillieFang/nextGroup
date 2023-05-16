//
//  RoomDetailViewController.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation
import UIKit

class RoomDetailViewController: UIViewController {
    private var titleLabel: UILabel!
    private var detailStackView: UIStackView!
    private var datePicker: UIDatePicker!
    private var fromLabel: UILabel!
    private var fromTimeButton: UIButton!
    private var toTimeLabel: UILabel!
    private var dateLabel : UILabel!
    private var toLabel: UILabel!
    private var confirmButton: UIButton!
    
    private var buildingNumber: String = ""
    private var buildingLevel: String = ""
    private var roomNumber: String = ""
    private var capacity: Int = 0
    private var roomType: String = ""
    private var facilities: String = ""
    
    let timeOptions: [String] = {
        var options: [String] = []
        for i in 0...24 {
            let timeString = String(format: "%02d:00", i)  // Add ":00" for minutes
            options.append(timeString)
        }
        return options
    }()

    
    convenience init(buildingNumber: String, buildingLevel: String, roomNumber: String, capacity: Int, roomType: String, facilities: String) {
        self.init()
        self.buildingNumber = buildingNumber
        self.buildingLevel = buildingLevel
        self.roomNumber = roomNumber
        self.capacity = capacity
        self.roomType = roomType
        self.facilities = facilities
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .white
        
        // Title Label
        titleLabel = UILabel()
        titleLabel.text = "B\(buildingNumber).\(buildingLevel).\(roomNumber)"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Detail StackView
        detailStackView = UIStackView()
        detailStackView.axis = .vertical
        detailStackView.spacing = 8
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailStackView)
        
        // Detail Info
        addDetailInfo(label: "Room Type", value: roomType)
        addDetailInfo(label: "Facilities", value: facilities)
        addDetailInfo(label: "Capacity", value: "\(capacity)")
        
        dateLabel = UILabel()
        dateLabel.text = "Date"
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        
        // Date Picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        // From Label
        fromLabel = UILabel()
        fromLabel.text = "From"
        fromLabel.font = UIFont.systemFont(ofSize: 18)
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromLabel)
        
        // From Minute Picker
        fromTimeButton = UIButton(type: .system)
        fromTimeButton.setTitle("Choose Time", for: .normal)
        fromTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)  // Set the font size here
        fromTimeButton.addTarget(self, action: #selector(fromTimeButtonTapped(_:)), for: .touchUpInside)
        fromTimeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromTimeButton)
        
        
        // To Label
        toLabel = UILabel()
        toLabel.text = "To"
        toLabel.font = UIFont.systemFont(ofSize: 18)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toLabel)
        
        
        // To Minute Picker
        toTimeLabel = UILabel()
        toTimeLabel.text = "-"
        toTimeLabel.font = UIFont.systemFont(ofSize: 16)
        toTimeLabel.textColor = .gray // or any other color
        toTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toTimeLabel)
        
        // Confirm Button
        confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        confirmButton.setTitleColor(.white, for: .normal)  // Change text color to white
        confirmButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)  // Add padding above and below the button's text
        confirmButton.backgroundColor = .blue
        confirmButton.layer.cornerRadius = 22
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped(_:)), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmButton)

        
        updateConfirmButtonColor()
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailStackView.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -80), // Add this line
            
            dateLabel.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 80), // Update this line
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            
            fromLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromTimeButton.leadingAnchor.constraint(greaterThanOrEqualTo: fromLabel.trailingAnchor, constant: 8),
            fromTimeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fromTimeButton.centerYAnchor.constraint(equalTo: fromLabel.centerYAnchor),
            
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 20),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toTimeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: toLabel.trailingAnchor, constant: 8),
            toTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toTimeLabel.centerYAnchor.constraint(equalTo: toLabel.centerYAnchor),
            
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        fromLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        fromTimeButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        toLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        toTimeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        
        
        
        // Set initial values
        let currentDate = Date()
        datePicker.date = currentDate
        
        // Confirm Button action
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func addDetailInfo(label: String, value: String) {
        let infoLabel = UILabel()
        infoLabel.text = "\(label): \(value)"
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        detailStackView.addArrangedSubview(infoLabel)
    }
    
    @objc private func fromTimeButtonTapped(_ sender: UIButton) {
        var menuItems: [UIAction] = []
        
        for i in 0..<timeOptions.count - 1 {
            menuItems.append(UIAction(title: timeOptions[i], handler: { [weak self] action in
                guard let self = self else { return }
                self.fromTimeButton.setTitle(action.title, for: .normal)
                let toTime = String(format: "%02d:00", min(Int(action.title.prefix(2))! + 2, 23))  // Add two hours
                self.toTimeLabel.text = toTime
                
                self.updateConfirmButtonColor()
            }))
        }
        
        let menu = UIMenu(title: "Choose Time", children: menuItems)
        fromTimeButton.menu = menu
        fromTimeButton.showsMenuAsPrimaryAction = true
    }
    
    private func updateConfirmButtonColor() {
        if fromTimeButton.title(for: .normal) == "Choose Time" {
            confirmButton.backgroundColor = .gray
            confirmButton.isEnabled = false
        } else {
            confirmButton.backgroundColor = .blue
            confirmButton.isEnabled = true
        }
    }

    @objc private func confirmButtonTapped(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMM d, yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)

        let fromTime = fromTimeButton.title(for: .normal) ?? "00:00"
        let toTime = toTimeLabel.text ?? "00:00"

        // Save to UserDefaults
        var user = User(buildingNumber: buildingNumber, buildingLevel: buildingLevel, roomNumber: roomNumber, selectedDate: selectedDate, fromTime: fromTime, toTime: toTime)
        user.registerDate = Date()
        if var savedUsers = UserDefaults.standard.object(forKey: "Users") as? Data {
            let decoder = JSONDecoder()
            if var loadedUsers = try? decoder.decode([User].self, from: savedUsers) {
                loadedUsers.append(user)
                if let encoded = try? JSONEncoder().encode(loadedUsers) {
                    UserDefaults.standard.set(encoded, forKey: "Users")
                }
            }
        } else {
            if let encoded = try? JSONEncoder().encode([user]) {
                UserDefaults.standard.set(encoded, forKey: "Users")
            }
        }
        
        let alert = UIAlertController(title: "Confirmation", message: "You have booked the B\(buildingNumber).\(buildingLevel).\(roomNumber) from \(fromTime) to \(toTime) on \(selectedDate).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }

}
