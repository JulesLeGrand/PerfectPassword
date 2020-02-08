//
//  AESCipher.swift
//  PerfectPassword
//
//  Created by Julio on 05/02/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import CryptoKit

class AESCipher: CipherTasksDelegate {
    
    
    func saveInputData(key: String, passcodeLength: Int, characterSet: String) {
                let ud = UserDefaults.standard
        ud.set(characterSet, forKey: "characterSet")
        ud.set(passcodeLength, forKey: "passCodeLength")
        ud.set(key, forKey: "key")
        ud.synchronize()
    }
    
    func retrieveInitialData() -> (key: String, passLength: Int, charSet: String, cardArray: [String]) {
            let ud = UserDefaults.standard
        guard let key = ud.string(forKey: "key"), let length = ud.integer(forKey: "passCodeLength") as Int?, let charSet = ud.string(forKey: "characterSet"), let cardArray = ud.array(forKey: "cardArray")  else { return ("",0,"", [])}
        return (key, length, charSet, cardArray as! [String])
    }
    
    
    var cardArray: [String] = ["HOLA"]
    
    func getCard(passLength: Int, charSet: String) -> [String] {
        debugPrint("Datos de entrada desde AESCipher --> \(passLength) + \(charSet)")
        let key = getNewKey()
        saveInputData(key: getSequenceKeyToHex(key: key), passcodeLength: passLength, characterSet: charSet)
        let characterSetArray = Array(charSet)
        var remainderArray = [Int]()
        var mapedArray = [Character]()
        var cardArray = [String]()
        
        for actual in 0...349 {
            do {
                let cipherText = getCipherText(key: key , message: String(format: "%016d", actual))
                let divisor = UInt128(passLength)
                let dividendo = try UInt128(cipherText)
                let remainder = Int(dividendo.quotientAndRemainder(dividingBy: divisor).remainder)
                remainderArray.append(remainder)
            } catch {
                print("We have a problem my friend -> \(error)")
            }
        }
        mapedArray = remainderArray.map({characterSetArray[$0]})
        for i in stride(from: 0, to: mapedArray.count, by: passLength - 1) {
            let miVar = min((i + (passLength - 1)), mapedArray.count - 1)
            let cadena = mapedArray[i...miVar]
            cardArray.append(String(cadena))
        }
        saveCardArray(cardArray: cardArray)
        return cardArray
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
    
    func getCipherText(key: SymmetricKey, message: String) -> String {
        var myArray = [String]()
        do {
            let data = Data(message.utf8)
            let mySealedBox = try AES.GCM.seal(data, using: key, nonce: nil)
            let cipherText = mySealedBox.ciphertext.withUnsafeBytes { return Array($0) }
    //        print("El cifrado : \(cipherText)")
            for numbers in cipherText {
                myArray.append(String(format: "%02X", numbers))
            }
        } catch {
            print("We have a problem my friend -> \(error)")
        }
        return "0x\(myArray.joined())"
    }
    
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
    
    func saveCardArray(cardArray: [String]) {
        let ud = UserDefaults.standard
        ud.set(cardArray, forKey: "cardArray")
        ud.synchronize()
    }
    
    func retrieveCardArray() -> [String]{
        let ud = UserDefaults.standard
        guard let cardArray = ud.array(forKey: "cardArray") else { return [String]()}
        return cardArray as! [String]
    }
}
