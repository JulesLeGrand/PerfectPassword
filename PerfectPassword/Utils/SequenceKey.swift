//
//  SequenceKey.swift
//  PerfectPassword
//
//  Created by Julio on 05/02/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import CryptoKit

class SequenceKey {
    
    func getNewKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    func getSequenceKeyToHex(key: SymmetricKey) -> String {
        var myArray = [String]()
        let keyBytes = key.withUnsafeBytes{ return Array($0) }
        for number in keyBytes {
            myArray.append(String(format: "%02X", number))
        }
        return myArray.joined()
    }
}
