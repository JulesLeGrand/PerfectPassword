//
//  FormUIEventsDelegate.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import UIKit
import CryptoKit

protocol FormUIEventsDelegate {
    
    func textEditTapped()
    func generatePassTapped(passLength: Int, charSet: String)
    func newSequenceTapped()
    func stepperTapped(length: Int)
}

protocol HandleDataDelegate {
    func getNewSequenceKey() -> (keyObject: Any, keyString: String)
    func saveKey(key: String)
    func retrieveKey() -> String
    func retrieveInitialData() -> (key: String, passLength: Int, charSet: String, cardArray: [String])
}

protocol CipherTasksDelegate {
    func getCardAndKey(passLength: Int, charSet: String) -> (cardArray: [String], key: String)
    func saveInputData(key: String, characterSet: String, initialCounter: Int)
    func retrieveInitialData() -> (key: String, charSet: String, cardArray: [String])
}
