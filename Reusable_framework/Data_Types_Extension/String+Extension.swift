//
//  StringExtension.swift
//  AppBuilder
//
//  Created by Amit Chowdhury on 9/6/20.
//  Copyright © 2020 BJIT. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var isValidPassword:Bool{
        if(self.isAlphanumericLageSmall && self.count>=10){
            return true
        }
        return false
    }

    var isValidEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
    var isValidPhone: Bool {
       let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
       let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
       return testPhone.evaluate(with: self)
    }

    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }

    var containsOnlyLetters: Bool {
        let notLetters = NSCharacterSet.letters.inverted
        return rangeOfCharacter(from: notLetters, options: String.CompareOptions.literal, range: nil) == nil
    }

    var isAlphanumeric: Bool {
        let notAlphanumeric = NSCharacterSet.decimalDigits.union(NSCharacterSet.letters).inverted
        return rangeOfCharacter(from: notAlphanumeric, options: String.CompareOptions.literal, range: nil) == nil
    }

    var isAlphanumericLageSmall: Bool {
        if (self.rangeOfCharacter(from: CharacterSet.uppercaseLetters)==nil){
            return false
        }else if (self.rangeOfCharacter(from: CharacterSet.lowercaseLetters)==nil){
            return false
        }else if (self.rangeOfCharacter(from: CharacterSet.decimalDigits)==nil){
            return false
        }else{
            return true
        }
    }
    //phrase.wordCount
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }

    /*
     Swift’s strings have a built-in method for replacing all instances of a substring with another, but if you want only a fixed number of replacements you need to do it yourself.

     One smart solution here is to call range(of:) repeatedly, replacing instances of the substring until a maximum replacements parameter is reached.


     let phrase = "How much wood would a woodchuck chuck if a woodchuck would chuck wood?"
     print(phrase.replacingOccurrences(of: "would", with: "should", count: 1))
     **/

    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }

        return returnValue
    }

    /*

     UIKit’s labels do a great job of truncating strings to a specific length, but for other purposes – such as writing out to a file, rendering to an image, or showing messages – we need to roll something ourselves.


     let testString = "He thrusts his fists against the posts and still insists he sees the ghosts."
     print(testString.truncate(to: 20, addEllipsis: true))

     **/
    func truncate(to length: Int, addEllipsis: Bool = false) -> String  {
        if length > count { return self }

        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]

        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }

    /*
     If you have a collection of URLs like “www.bjitgroup.com” and you want to make sure they all start with “https://“, you might write something like this:

     let url = "www.bjitgroup.com"
     let fullURL = url.withPrefix("https://")
     **/
    
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }

    /*
     convert a string a underline MutableAttributeString with  define  color  and font
     **/
    func underLineMutableString(font:UIFont,lineHight:CGFloat,letterSpace:CGFloat,textColor:UIColor,underlineColor:UIColor)-> NSMutableAttributedString{
        let nsmutableString  =  NSMutableAttributedString(string:self, attributes: [.foregroundColor: textColor, .font: font,.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:underlineColor])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHight
        nsmutableString.addAttribute(.paragraphStyle,value: paragraphStyle,range: NSRange(location: 0, length: self.count))
        nsmutableString.addAttribute(NSAttributedString.Key.kern, value: letterSpace, range: NSMakeRange(0, self.count))
        return nsmutableString
    }

    /*
    convert a string a MutableAttributeString with  define  color  and font
    **/
    func convertToMutableString(font:UIFont,lineHight:CGFloat,letterSpace:CGFloat,textColor:UIColor) -> NSMutableAttributedString {
        let nsmutableString  =  NSMutableAttributedString(string:self, attributes: [.foregroundColor: textColor, .font: font])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHight
        nsmutableString.addAttribute(.paragraphStyle,value: paragraphStyle,range: NSRange(location: 0, length: self.count))
        nsmutableString.addAttribute(NSAttributedString.Key.kern, value: letterSpace, range: NSMakeRange(0, self.count))
        return nsmutableString
    }

    func convertToMutableString(font:UIFont,lineHight:CGFloat,textColor:UIColor) -> NSAttributedString {
        let nsmutableString  =  NSMutableAttributedString(string:self, attributes: [.foregroundColor: textColor, .font: font])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHight
        nsmutableString.addAttribute(.paragraphStyle,value: paragraphStyle,range: NSRange(location: 0, length: self.count))
        return nsmutableString
    }

    /*
    format phone number for max 10 digit

     xxx-xxxx  //for less than eight digit
     xxx-xxx-xxxx //for greater than eight digit and less than 11 digit
    **/

    func formatPhoneNumber(shouldRemoveLastDigit: Bool = false,maxDigit: Int = 11,isHomeNumber: Bool = false ) -> String {
        guard !self.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: self).range(of: self)
        var number = regex.stringByReplacingMatches(in: self, options: .init(rawValue: 0), range: r, withTemplate: "")

        if number.count > maxDigit {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: maxDigit)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }

        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }

        if isHomeNumber{
            if number.count <= 6 {
                let end = number.index(number.startIndex, offsetBy: number.count)
                let range = number.startIndex..<end
                number = number.replacingOccurrences(of: "(\\d{2})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
            } else {
                let end = number.index(number.startIndex, offsetBy: number.count)
                let range = number.startIndex..<end
                number = number.replacingOccurrences(of: "(\\d{2})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            }
        }else{
            if number.count <= 7 {
                let end = number.index(number.startIndex, offsetBy: number.count)
                let range = number.startIndex..<end
                number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
            } else {
                let end = number.index(number.startIndex, offsetBy: number.count)
                let range = number.startIndex..<end
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            }
        }

        return number
    }

    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: Float(self)!))!
    }

    var extractNumber: String {
        let okayChars = Set("1234567890")
        return self.filter {okayChars.contains($0) }
    }

    var extractEmail:String?{
        if let name = self.components(separatedBy: CharacterSet(charactersIn: ("@"))).first {
            return name
        }
        return nil
    }
    
    func getTextHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    //  ----------------------------------------------------------------------
    private var ns: NSString {
        return (self as NSString)
    }

    
    //  ----------------------------------------------------------------------
    /// The last path component of the receiver.
    public var lastPathComponent: String {
        return ns.lastPathComponent
    }
    
    //  ----------------------------------------------------------------------
    /// The path extension, if any, of the string as interpreted as a path.
    public var pathExtension: String {
        return ns.pathExtension
    }
    
    //  ----------------------------------------------------------------------
    /// A new string made by deleting the last path component from the receiver, along with any final path separator.
    public var deletingLastPathComponent: String {
        return ns.deletingLastPathComponent
    }
    
    //  ----------------------------------------------------------------------
    /// A new string made by deleting the extension (if any, and only the last) from the receiver.
    public var deletingPathExtension: String {
        return ns.deletingPathExtension
    }
    
    //  ----------------------------------------------------------------------
    /// The file-system path components of the receiver.
    public var pathComponents: [String] {
        return ns.pathComponents
    }

    public static func addComma(_ value: Int, maximumFractionDigits: Int = 0) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(from: NSNumber(value: value)) ?? String(value)
    }

    func stringToFloat() -> Float {
        if let n = NumberFormatter().number(from: self) {
            return Float(truncating: n)
        }
        return 0.0
    }

    func stringToDouble() -> Double {
        if let n = NumberFormatter().number(from: self) {
            return Double(truncating: n)
        }
        return 0.0
    }

    //MARK:- Whate space and new lines
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed
    }

    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }

    var asURL: URL? {
        URL(string: self)
    }

    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }

    /*
     var cardNumber = "1234567890123456"
     cardNumber.insert(separator: " ", every: 4)
     print(cardNumber)
     // 1234 5678 9012 3456
     let pin = "7690"
     let pinWithDashes = pin.inserting(separator: "-", every: 1)
     print(pinWithDashes)
     // 7-6-9-0
     **/
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }

    
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }

        return returnValue
    }

    /*
     let phrase = "How much wood would a woodchuck chuck if a woodchuck would chuck wood?"
     print(phrase.replacingOccurrences(of: "would", with: "should", count: 1))
     **/
    
    
}



extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}
