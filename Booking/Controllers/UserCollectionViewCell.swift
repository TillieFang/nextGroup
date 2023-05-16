//
//  UserCollectionViewCell.swift
//  Booking
//
//  Created by Aileen Tsai on 14/5/2023.
//

import Foundation
import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    static let identifier = "UserCell"
    
    private let bookingInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bookingInfoLabel)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.25
        
        NSLayoutConstraint.activate([
            bookingInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookingInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: User) {
        bookingInfoLabel.text = """
        B\(user.buildingNumber).\(user.buildingLevel).\(user.roomNumber)
        Selected Date: \(user.selectedDate)
        From Time: \(user.fromTime)
        To Time: \(user.toTime)
        """
    }
}
