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
            let cardArray = cipherTasks.getCardAndKey(passLength: passLength, charSet: charSet)
            cardVC.customInitSymmetric(cardContent: cardArray.cardArray)
            self.navigationController?.pushViewController(cardVC, animated: true)
            tabBarController?.selectedIndex = 1
        } else {
            //TODO: COntruye tarjeta y muestrala
//            showDataView.sequenceKeyLbl.text = initialData.key
            debugPrint("YA existe tarjeta")
            self.inflatePassCard()
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
            self.inflatePassCard()
        }
        alert.addAction(cancel)
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
    func inflatePassCard() {
        guard let charSet = self.showDataView.characterSetTV.text else { return }
        let cardArrayAndKey = self.cipherTasks.getCardAndKey(passLength: 11, charSet: charSet)
        self.showDataView.sequenceKeyLbl.text = cardArrayAndKey.key
        self.cardVC.customInitSymmetric(cardContent: cardArrayAndKey.cardArray)
        self.navigationController?.pushViewController(self.cardVC, animated: true)
        self.tabBarController?.selectedIndex = 1
    }
    
}

extension ShowParametersViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        debugPrint("textViewDidBeginEditing")
    }
    
}
