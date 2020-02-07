//
//  FormUIEventsDelegate.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import UIKit

protocol FormUIEventsDelegate {
    
    func textEditTapped()
    func generatePassTapped(inputData: InputData)
    func newSequenceTapped()
    func stepperTapped(length: Int)
}

protocol HandleDataDelegate {
    func getNewSequenceKey() -> String
}
