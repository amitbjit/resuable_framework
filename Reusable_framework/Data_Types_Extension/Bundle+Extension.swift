//
//  BundleExtension.swift
//  AppBuilder
//
//  Created by Amit Chowdhury on 11/6/20.
//  Copyright © 2020 BJIT. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    var appVersion: String? {
           self.infoDictionary?["CFBundleShortVersionString"] as? String
       }
       
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }

    /*
     check plist file and key value of the plist
     ofName -> plist name
     key -> key name
     return -> value object of key either nil

     **/

    func parsePlist(ofName name: String,key:String) -> AnyObject? {
        // check if plist data available
        guard let plistURL = Bundle.main.url(forResource: name, withExtension: "plist"),
            let data = try? Data(contentsOf: plistURL)
            else {
                return nil
        }
        // parse plist into [String: Anyobject]
        guard let plistDictionary = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: AnyObject] else {
            return nil
        }

        guard let value = plistDictionary[key]
            else{
                return nil
        }
        return value
    }
    
    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }

        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }

        let decoder = JSONDecoder()

        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode \(filename) from app bundle.")
        }

        return result
    }

}
