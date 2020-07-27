//
//  StatisticsViewController.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    // This view displays values of the current user from UserDefaults and the leaderboard from the archive
    
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var tfLatest: UITextField!
    @IBOutlet weak var tfSecondLatest: UITextField!
    @IBOutlet weak var tfThirdLatest: UITextField!
    @IBOutlet weak var tfTries: UITextField!
    @IBOutlet weak var tvUsersList: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Fill all fields with defaults values
        let defaults = UserDefaults.standard
        lbUsername.text = "\(defaults.value(forKey: "username") ?? "NO USERNAME")"
        tfLatest.text = "\((defaults.object(forKey: "latesttries") as? [Int])?[0] ?? -1)"
        tfSecondLatest.text = "\((defaults.object(forKey: "latesttries") as? [Int])?[1] ?? -1)"
        tfThirdLatest.text = "\((defaults.object(forKey: "latesttries") as? [Int])?[2] ?? -1)"
        tfTries.text = "\(defaults.value(forKey: "totaltries") ?? -1)"
        // Without archive working, leaderboard cannot be filled with history of users
    }
}
