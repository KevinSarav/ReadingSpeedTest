//
//  SpeedTest.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation
import UIKit

class SpeedTest
{
    // This class performs the speed test. It updates its view controller's labels using the view controller's array of words.
    var status: Status!
    var timer = Timer()
    var lbWord: UILabel!
    var lbStatus: UILabel!
    var words = Array<String>()
    var interval: Double!
    
    init(_ lbWord: UILabel, _ lbStatus: UILabel, _ randomParagraph: Array<String>, _ wpm: Int) {
        status = Status()
        self.lbWord = lbWord
        self.lbStatus = lbStatus
        words = randomParagraph
        // Convert words per minute to interval for timer
        interval = 60.0 / Double(wpm)
    }
    
    func start() {
        // Used in view controller to start the speed test
        // If there is no timer already:
        if !timer.isValid {
            // Set timer with user's speed and perform nextWord() at each tick
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(SpeedTest.nextWord), userInfo: nil, repeats: true)
        }
    }
    
    @objc func nextWord() {
        // Move to next word on each tick
        // If there are still words left in paragraph:
        if !words.isEmpty {
            // Remove first word and display it in label
            lbWord.text = words.remove(at: 0)
            // Turn text color black before highlighting middle of word
            lbWord.textColor = UIColor.black
            highlightMiddleOfWord()
            status.createMessage(lbStatus, "Test underway...")
        } else {
            // End timer, empty label and display success
            timer.invalidate()
            lbWord.text = ""
            status.successMessage(lbStatus, "Test complete.")
        }
    }
    
    func highlightMiddleOfWord() {
        let length = lbWord.text!.count
        // Length too small to make an attribute, so turn every character red
        if length < 3 {
            lbWord.textColor = UIColor.red
        } else {
            var middle = length / 2
            // Decrement middle index if length is even to get highlighting correct
            if length % 2 == 0 {
                middle -= 1
            }
            // range's length is 1 if length is odd or 2 if length is even
            let rangeLength = abs(length % 2 - 2)
            let range = NSRange(location: middle, length: rangeLength)
            let attributeText = NSMutableAttributedString(string: lbWord.text!)
            // Change middle character(s) to red then update label
            attributeText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
            lbWord.attributedText = attributeText
        }
    }
}
