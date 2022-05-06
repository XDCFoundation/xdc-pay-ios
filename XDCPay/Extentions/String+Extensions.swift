//
//  String+Extensions.swift
//  Babypass
//
//  Created by iOS Developer on 2021-08-29.
//

import Foundation
import UIKit

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    /** Gets how many placeholders the string has.  e.i. %.2f, %@, %d, %i  */
    func getNumberOfExpectedParameters() -> Int {
        let numberOfEscapeCharacters: Int = self.getOccurenceCountOf(substring: "%", allowInnerRepetition: false)
        let numberOfEscapeCharactersForPercentageSigns: Int = self.getOccurenceCountOf(substring: "%%", allowInnerRepetition: false)
        let numberOfExpectedParameters: Int = numberOfEscapeCharacters - (numberOfEscapeCharactersForPercentageSigns * 2)
        return numberOfExpectedParameters
    }

    /**
     Gets how many times a substring appears within a string.  Optimized for low CPU instructions and performance.
     - Parameter allowInnerRepetition: After a successful find if should come back to next character of found word or to skip characters in found word.
     */
    func getOccurenceCountOf(substring: String, allowInnerRepetition: Bool = false) -> Int {
        // Get how many characters in the main string
        let selfCount: Int = self.count
        if selfCount == 0 {
            return 0
        }

        // Get how many characters in the substring
        let otherCount: Int = substring.count
        if otherCount == 0 {
            return 0
        }

        // If there are more characters in the substring, no matches
        if otherCount > selfCount {
            return 0
        }

        // Make sure the compiler doesn't calculate this every loop
        let otherCountMinus1: Int = otherCount - 1

        // Get as C strings
        let selfString: [String.UTF16View.Element] = self.utf16.map { $0 }
        let otherString: [String.UTF16View.Element] = substring.utf16.map { $0 }

        var result: Int = 0 // Container for the result ammount of matches
        var currentIndex: Int = 0 // The current index in the main string
        var innerIndex = 0 // The index within the comparison once there is a match in the first character

        // The ammount to change the index after a successful find depending on mode.
        let incrementAfterSuccess: Int = allowInnerRepetition ? 1 : otherCount

        while currentIndex + innerIndex < selfCount {
            // If there is no match from current index, continue to next character in the main string
            if selfString[currentIndex + innerIndex] != otherString[innerIndex] {
                currentIndex += 1
                innerIndex = 0
                continue
            }

            // If there is not a full match yet, keep going
            if innerIndex != otherCountMinus1 {
                innerIndex += 1
                continue
            }

            // If there is a match
            result += 1
            currentIndex += incrementAfterSuccess
            innerIndex = 0
        }

        return result
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    /**
     Strips the specified characters from the beginning of string.

     - parameter set: Give character set to apply on string for trimming

     - returns: A String trimmed after left whitespace
     */
    func trimmedLeft(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {

        if let range = rangeOfCharacter(from: set.inverted) {
            return String(self[range.lowerBound ..< endIndex])
        }

        return ""
    }

    @available(*, unavailable, message: "use 'trimmedLeft' instead") func ltrimmed(_ set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {

        return trimmedLeft(characterSet: set)
    }

    /**
     Strips the specified characters from the end of string.

     - parameter set: Give character set to apply on string for trimming

     - returns: A String trimmed after right whitespace
     */
    func trimmedRight(characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {

        if let range = rangeOfCharacter(from: set.inverted, options: NSString.CompareOptions.backwards) {
            return String(self[startIndex ..< range.upperBound])
        }

        return ""
    }

    @available(*, unavailable, message: "use 'trimmedRight' instead") func rtrimmed(_ set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {

        return trimmedRight(characterSet: set)
    }

    /**
     Strips whitespaces from both the beginning and the end of string.

     - returns: A String after trimmed white space
     */
    func trimmed() -> String {

        return trimmedLeft().trimmedRight()
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
