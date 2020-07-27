//
//  Paragraph.swift
//  ReadingSpeedTest
//
//  Created by Saravia, Kevin on 7/25/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation

class Paragraph
{
    // This class stores the contents of /Resources/paragraphs.txt into an array of paragraphs.
    // This class also returns a random paragraph array of words upon SpeedTestViewController's request.
    var paragraphs = Array<String>()
    
    init() {
        // If paragraphs.txt exists:
        if let path = Bundle.main.path(forResource: "paragraphs", ofType: "txt") {
            // If contents can be extracted as a string:
            if let contents = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
                // Store contents in paragraphs array separated by line
                paragraphs = contents.components(separatedBy: "\n")
            }
        }
        // If any if statements fail, leave paragraphs array empty
    }
    
    func getParagraph() -> [String] {
        // If class initialization was successful:
        if !paragraphs.isEmpty {
            // Return random paragraph array separated by white spaces
            let randomParagraphIndex = Int.random(in: 0..<paragraphs.count)
            return paragraphs[randomParagraphIndex].components(separatedBy: " ")
        }
        // Else, return array with empty string
        return [""]
    }
}
