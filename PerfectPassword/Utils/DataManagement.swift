//
//  DataManagement.swift
//  PerfectPassword
//
//  Created by Julio on 05/02/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation

class DataManagement: HandleDataDelegate {
    
    func getNewSequenceKey() -> String {
        let sequenceKey = SequenceKey()
        let key = sequenceKey.getSequenceKeyToHex(key: sequenceKey.getNewKey())
        print("In getNewSequenceKey")
        return key
    }
}
