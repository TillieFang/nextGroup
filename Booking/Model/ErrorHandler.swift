//
//  ErrorHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 20/5/2023.
//

import Foundation

// Struct to handle errors based on their ID
struct ErrorHandler {
        
    // Function to return an error message when an ID is provided
    func showErrorMessage(errorID : Int) -> String {
        var errorText = "Error \(errorID)"
        
        switch(errorID){
        case 1:
            errorText += ". Invalid building selection, please select a valid building in the previous window."
            break;
        case 2:
            errorText += ". Invalid room selection, please select a valid room."
            break;
        case 3:
            errorText += ". Invalid date selection, please select a valid date before booking."
            break;
        case 4:
            errorText += ". Invalid time selection, please select a valid time before booking."
            break;
        case 5:
            errorText += ". Invalid booking duration, please select a valid booking duration before booking."
            break;
        case 6:
            errorText += ". Invalid email, please login again to restore your session."
            break;
        case 7:
            errorText += ". Invalid booking key, we weren't able to find your booking."
            break;
        case 8:
            errorText += ". Failed to format the booking time."
            break;
        case 9:
            errorText += ". Failed to format the booking date."
            break;
        case 10:
            errorText += ". Failed to get the booking date key."
            break;
        default:
            errorText += ", unknown error."
            break;
        }        
        return errorText
    }
}
