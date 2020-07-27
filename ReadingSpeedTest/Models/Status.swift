//
//  Status.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class Status
{
    // This class stores the functions for displaying error and success messages, along with special messages.
    
    func successMessage(_ label: UILabel, _ message: String) {
        label.backgroundColor = UIColor.green
        label.text = message
        label.isHidden = false
    }
    
    func errorMessage(_ label: UILabel, _ message: String) {
        label.backgroundColor = UIColor.red
        label.text = message
        label.isHidden = false
    }
    
    func createMessage(_ label: UILabel, _ message: String) {
        label.backgroundColor = UIColor.yellow
        label.text = message
        label.isHidden = false
    }
}
