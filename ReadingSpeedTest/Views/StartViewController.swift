//
//  ViewController.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate {
    // This view is the login screen.
    var userDB: UserDB!
    var status: Status!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var lbStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfUsername.delegate = self
        tfUsername.becomeFirstResponder()
        userDB = UserDB()
        status = Status()
        // Archiving does not work. This line would retrieve all users from archive
        //userDB.unarchive()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfUsername.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Archiving doesn't work, so this if statement is never true
        /*if let user = userDB.users.first(where: { $0.username == tfUsername.text }) {
            status.successMessage(lbStatus, "Welcome back, \(tfUsername.text!)")
            userDB.setCurrentUser(user)
        } else {*/
            status.createMessage(lbStatus, "Creating new user...")
            userDB.createNewUser(tfUsername.text!)
        //}
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfUsername.text == "" {
            let defaults = UserDefaults.standard
            // If username key previously exists in UserDefaults:
            if let _ = defaults.value(forKey: "username") {
                return true
            } else {
                status.errorMessage(lbStatus, "First time username required.")
                return false
            }
        }
        return true
    }
}

