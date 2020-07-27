//
//  SpeedTestViewController.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class SpeedTestViewController: UIViewController, UITextFieldDelegate {
    // This view is used to conduct the speed test.
    // This view uses /Models/Paragraph.swift to extract a random paragraph from /Resources/paragraphs.txt and then uses /Models/SpeedTest.swift to perform the actual test.
    var paragraph: Paragraph!
    var speedtest: SpeedTest!
    var status: Status!
    
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var tfWPM: UITextField!
    @IBOutlet weak var lbWord: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfWPM.keyboardType = UIKeyboardType.numberPad
        self.tfWPM.delegate = self
        tfWPM.becomeFirstResponder()
        paragraph = Paragraph()
        status = Status()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Update username and WPM if changed in settings view
        tfWPM.becomeFirstResponder()
        let defaults = UserDefaults.standard
        lbUsername.text = "\(defaults.value(forKey: "username") ?? "NO USERNAME")"
        tfWPM.text = "\(defaults.value(forKey: "defaultspeed") ?? -1)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func startTest(_ sender: Any) {
        self.view.endEditing(true)
        tfWPM.resignFirstResponder()
        // If there is no ongoing speed test:
        if lbStatus.text != "Test underway..." && lbStatus.text != "Test already underway." {
            // If file reading was successful:
            if !paragraph.paragraphs.isEmpty {
                let defaults = UserDefaults.standard
                // Initiate starting delay then get random paragraph
                sleep(UInt32(defaults.value(forKey: "startingdelay") as? Int ?? 1))
                // Basically making a separate array, updating that, and then setting UserDefault's array with the new array
                var tries = defaults.object(forKey: "latesttries") as? Array<Int>
                tries?.insert(Int(tfWPM.text!) ?? 0, at: 0)
                let triesSize = (tries?.count ?? 3) - 1
                // Remove oldest entry to save memory
                tries?.remove(at: triesSize)
                defaults.setValue(tries, forKey: "latesttries")
                defaults.setValue((defaults.value(forKey: "totaltries") as? Int ?? -1) + 1, forKey: "totaltries")
                defaults.setValue(Int(tfWPM.text!) ?? defaults.value(forKey: "defaultspeed"), forKey: "latesttries")
                // If field empty, use default speed from UserDefaults. If UserDefaults doesn't work, use 60 words/min
                let randomParagraph = paragraph.getParagraph()
                speedtest = SpeedTest(lbWord, lbStatus, randomParagraph, Int(tfWPM.text!) ?? (defaults.value(forKey: "defaultspeed") as? Int ?? 60))
                speedtest.start()
            } else {
                status.errorMessage(lbStatus, "Error reading input file.")
            }
        } else {
            status.errorMessage(lbStatus, "Test already underway.")
        }
    }
}
