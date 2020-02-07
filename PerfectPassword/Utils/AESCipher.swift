//
//  AESCipher.swift
//  PerfectPassword
//
//  Created by Julio on 05/02/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import CryptoKit

class AESCipher {
    
    func doCipher(key: SymmetricKey, message: String) -> String {
        var myString = ""
        do {
            let data = Data(message.utf8)
            let myIV = AES.GCM.Nonce()
            let mySealedBox = try AES.GCM.seal(data, using: key, nonce: myIV)
            myString = try String(decoding: AES.GCM.open(mySealedBox, using: key), as: UTF8.self)
        } catch {
            print("We have a problem my friend -> \(error)")
        }
        return myString
    }
    
    func getOriginal(nonce: AES.GCM.Nonce, cipherText: Data, tag: Data) -> (String,String) {
        var high = [String]()
        var low = [String]()
        let cipherText = cipherText.withUnsafeBytes { return Array($0) }
        for (index, numbers) in cipherText.enumerated() {
            switch index {
                case 0..<16:
                    low.append(String(format: "%02X", numbers))
                case 16..<32:
                    high.append(String(format: "%02X", numbers))
                default:
                    break
            }
        }
        return ("0x\(low.joined())", "0x\(high.joined())")
    }
    
}
