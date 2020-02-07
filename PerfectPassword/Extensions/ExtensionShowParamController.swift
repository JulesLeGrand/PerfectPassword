//
//  ExtensionShowParamController.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/4/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

extension ShowParametersViewController: FormUIEventsDelegate {
    func generatePassTapped(inputData: InputData) {
        debugPrint("Generate Btn Tapped")
        debugPrint(inputData)
        cardVC.customInit(inputData: inputData)
        self.navigationController?.pushViewController(cardVC, animated: true)
        tabBarController?.selectedIndex = 1
    }
    
    
    func stepperTapped(length: Int) {
        debugPrint("Passcode Lenght \(length)")
    }
    
    func newSequenceTapped() {
        let newKey = self.delegate!.getNewSequenceKey()
        updateKeyView(key: newKey)
        print("Nueva llave desde extension: \(newKey)")
        let uInt128: UInt128 = "0x5"
        let high: UInt128 = "0x0"
        let low: UInt128 = "0x18"
        let res = uInt128.dividingFullWidth((high: high, low: low))
        print(type(of: res))
        print(res)
    }
    
    
    func textEditTapped() {
        debugPrint("textEdit tapped")
    }
    
}

extension ShowParametersViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        debugPrint("textViewDidBeginEditing")
    }
    
}
