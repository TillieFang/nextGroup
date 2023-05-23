//
//  ViewController.swift
//  Booking
//
//  Created by Akshaya Mohanlal on 8/5/2023.
//

import UIKit

class LogInViewController: UIViewController {

    // Outlet connection to the textfields and button
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // Variable to store the user email
    var userEmail: String? = nil

    // Disable the login button until a valid email and password is provided
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        loginButton.isEnabled = false
        [emailTextField, passwordTextField].forEach({ $0.addTarget(self, action: #selector(textFieldInput), for: .editingChanged) })

        // Password text will be hidden and replaced with dots while typing
        passwordTextField.isSecureTextEntry = true
    }

    // Function to handle the email and password input
    @objc func textFieldInput(_ textField: UITextField) {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            isValidEmail(email)
        else {
            userEmail = nil
            loginButton.isEnabled = false
            return
        }
        
        userEmail = emailTextField.text!
        
        loginButton.isEnabled = true
    }
    
    // Function to verify if the email is valid using RegExp
    func isValidEmail(_ email: String) -> Bool {
        // RegEx to verify Email structure
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {}

    // Function to open the Settings view and assign the user email
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            let settingsViewController = segue.destination as! SettingsViewController;
            settingsViewController.userEmail = userEmail
        }
    }
}

