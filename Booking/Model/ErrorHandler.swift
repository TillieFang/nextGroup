//
//  ErrorHandler.swift
//  Booking
//
//  Created by Andres Gonzalez on 20/5/2023.
//

import Foundation

struct ErrorHandler {
    
    func showErrorMessage(errorID : Int) -> String {
        var errorText = "Error \(errorID)"
        
        switch(errorID){
        case 1:
            errorText += ". Invalid date, please select a valid date."
            break;
        case 2:
            errorText += ". Invalid booking time, please select a valid booking time between 30 mins and 2 hours."
            break;
        case 3:
            break;
        default:
            errorText += ", unknown error"
            break;
        }
        
        print (errorText)
        return errorText
    }
}
