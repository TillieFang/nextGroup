//
//  ViewController.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    private var titleLabel: UILabel!
    private var filterButtonsStackView: UIStackView!
    private var tableView: UITableView!
    
    private var selectedBuildingNumber: String? = nil
    private var filteredRooms: [LibraryRoom] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Create and set "Welcome to UTS Library" labels
        titleLabel = UILabel()
        titleLabel.text = "Welcome to UTS Library"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Create and set up buttons
        let allButton = createFilterButton(title: "All")
        let building2Button = createFilterButton(title: "Building 2")
        let building6Button = createFilterButton(title: "Building 6")
        let building7Button = createFilterButton(title: "Building 7")
        let building11Button = createFilterButton(title: "Building 11")
        
        // Create and configure button stack view
        filterButtonsStackView = UIStackView(arrangedSubviews: [allButton, building2Button, building6Button, building7Button, building11Button])
        filterButtonsStackView.axis = .horizontal
        filterButtonsStackView.alignment = .center
        filterButtonsStackView.distribution = .equalSpacing // set regular intervals
        filterButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterButtonsStackView)
        
        
        // Creating and setting TableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Auto Layout Settings
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filterButtonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            filterButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: filterButtonsStackView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Initial data setup
        filteredRooms = rooms
        tableView.reloadData()
    }
    
    private func createFilterButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        
        // Set button style
        let normalTitleColor = UIColor.gray
        let selectedTitleColor = UIColor.white
        button.setTitleColor(normalTitleColor, for: .normal)
        button.setTitleColor(selectedTitleColor, for: .selected)
        button.setTitleColor(selectedTitleColor, for: [.selected, .highlighted]) // Maintain font color when touched in selected state
        button.isSelected = (title == "All") // Set initial selection state
        
        return button
    }
    
    
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            selectedBuildingNumber = nil
            
            switch title {
            case "All":
                filteredRooms = rooms
            case "Building 2":
                filteredRooms = rooms.filter { $0.buildingNumber == "02" }
                selectedBuildingNumber = "02"
            case "Building 6":
                filteredRooms = rooms.filter { $0.buildingNumber == "06" }
                selectedBuildingNumber = "06"
            case "Building 7":
                filteredRooms = rooms.filter { $0.buildingNumber == "07" }
                selectedBuildingNumber = "07"
            case "Building 11":
                filteredRooms = rooms.filter { $0.buildingNumber == "11" }
                selectedBuildingNumber = "11"
            default:
                break
            }
            
            // Updating the selection state of a filter button
            for button in filterButtonsStackView.arrangedSubviews {
                if let filterButton = button as? UIButton {
                    filterButton.isSelected = (filterButton.titleLabel?.text == title)
                }
            }
            
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let room = filteredRooms[indexPath.row]
        
        let roomLabel: UILabel
        if let existingLabel = cell.contentView.viewWithTag(100) as? UILabel {
            roomLabel = existingLabel
        } else {
            roomLabel = UILabel()
            roomLabel.translatesAutoresizingMaskIntoConstraints = false
            roomLabel.tag = 100
            cell.contentView.addSubview(roomLabel)
            
            NSLayoutConstraint.activate([
                roomLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                roomLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
        }
        
        roomLabel.text = "B\(room.buildingNumber).\(room.buildingLevel).\(room.roomNumber)"
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRoom = filteredRooms[indexPath.row]
        
        let roomDetailViewController = RoomDetailViewController(
            buildingNumber: selectedRoom.buildingNumber,
            buildingLevel: selectedRoom.buildingLevel,
            roomNumber: selectedRoom.roomNumber,
            capacity: selectedRoom.capacity,
            roomType: selectedRoom.roomType,
            facilities: selectedRoom.facilities
        )
        navigationController?.pushViewController(roomDetailViewController, animated: true)
    }
    
}
