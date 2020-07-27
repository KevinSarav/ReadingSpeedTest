//
//  SettingsViewController.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // This view changes the user, default speed, and start delay
    var status: Status!
    var userDB: UserDB!
    // Archive not working, so simulate a new user
    var pickedUsername: String = "Existing User"
    
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var tfDefaultSpeed: UITextField!
    @IBOutlet weak var pvUsername: UIPickerView!
    @IBOutlet weak var tfStartingDelay: UITextField!
    @IBOutlet weak var lbStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvUsername.delegate = self
        self.pvUsername.dataSource = self
        let defaults = UserDefaults.standard
        lbUsername.text = "\(defaults.value(forKey: "username") ?? "NO USERNAME")"
        tfDefaultSpeed.text = "\(defaults.value(forKey: "defaultspeed") ?? -1)"
        tfStartingDelay.text = "\(defaults.value(forKey: "startingdelay") ?? -1)"
        tfDefaultSpeed.keyboardType = UIKeyboardType.numberPad
        tfStartingDelay.keyboardType = UIKeyboardType.numberPad
        status = Status()
        userDB = UserDB()
        // Archive not working, so cannot retrieve users
        //userDB.unarchive()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func applySettings(_ sender: Any) {
        self.view.endEditing(true)
        if tfDefaultSpeed.text != "" && tfStartingDelay.text != "" {
            // Update user defaults
            let defaults = UserDefaults.standard
            defaults.setValue(tfDefaultSpeed.text!, forKey: "defaultspeed")
            defaults.setValue(pickedUsername, forKey: "username")
            defaults.setValue(tfStartingDelay.text!, forKey: "startingdelay")
            lbUsername.text = "\(defaults.value(forKey: "username") ?? "NO USERNAME")"
            status.successMessage(lbStatus, "Settings applied.")
        } else {
            status.errorMessage(lbStatus, "All fields required.")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Without archive working, cannot fill picker with users from userDB filled from archive
        return "Existing User"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Without archive working, cannot get picked user from userDB filled by archive
        //let index = pvUsername.selectedRow(inComponent: 0)
        //pickedUsername = userDB.users[index].username
    }
}
