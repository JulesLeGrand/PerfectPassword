//
//  ExtensionShowParamController.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/4/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit
import CryptoKit

extension ShowParametersViewController: FormUIEventsDelegate {
    
    func generatePassTapped(passLength: Int, charSet: String) {
        let initialData = cipherTasks.retrieveInitialData()
        print("Mi inicial data: \(initialData)")
        if initialData.key == "" {
            let cardArray = cipherTasks.getCard(passLength: passLength, charSet: charSet)
            cardVC.customInitSymmetric(cardContent: cardArray)
            self.navigationController?.pushViewController(cardVC, animated: true)
            tabBarController?.selectedIndex = 1
        } else {
            //TODO: COntruye tarjeta y muestrala
            debugPrint("YA existe tarjeta")
        }
    }
    
    
    func stepperTapped(length: Int) {
        debugPrint("Passcode Lenght \(length)")
    }
    
    func newSequenceTapped() {
        showAlertNewKey()
    }
    
    
    func textEditTapped() {
        debugPrint("textEdit tapped")
    }
    
    func showAlertNewKey() {
        let alert = UIAlertController (title: "!Atention!", message: "Are you sure to get a new key? All data will change...", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let yes = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            
            guard let length = self.showDataView.passcodeLengthLbl.text, let charSet = self.showDataView.characterSetTV.text else { return }
            let cardArray = self.cipherTasks.getCard(passLength: Int(length)!, charSet: charSet)
            self.cardVC.customInitSymmetric(cardContent: cardArray)
            self.navigationController?.pushViewController(self.cardVC, animated: true)
            self.tabBarController?.selectedIndex = 1
        }
        alert.addAction(cancel)
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ShowParametersViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        debugPrint("textViewDidBeginEditing")
    }
    
}
