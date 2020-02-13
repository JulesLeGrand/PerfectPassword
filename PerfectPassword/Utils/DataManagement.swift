//
//  DataManagement.swift
//  PerfectPassword
//
//  Created by Julio on 05/02/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import CryptoKit

class DataManagement: HandleDataDelegate {
    
    func retrieveKey() -> String {
        guard let myKey = UserDefaults.standard.string(forKey: "myKey") else {
        debugPrint("Error retrieving key")
        return "Error!"
        }
        return myKey
    }
    
    func getNewSequenceKey() -> (keyObject: Any, keyString: String) {
        let sequenceKey = SequenceKey()
        let key = sequenceKey.getNewKey()
        let keyString = sequenceKey.getSequenceKeyToHex(key: key)
        return (key, keyString)
    }
    
    func saveKey(key: String)  {
        let userDefaults = UserDefaults.standard
            userDefaults.set(key, forKey: "myKey")
            userDefaults.synchronize()
    }
    
    func retrieveInitialData() -> (key: String, passLength: Int, charSet: String, cardArray: [String]) {
            let ud = UserDefaults.standard
        guard let key = ud.string(forKey: "key"), let charSet = ud.string(forKey: "characterSet"), let cardArray = ud.array(forKey: "cardArray")  else {
            return ("",11,"!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz", [])
        }
        return (key, 11, charSet, cardArray as! [String])
    }
    
}
