//
//  ExtensionShowParamController.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/4/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

extension ShowParametersViewController: FormUIEventsDelegate {
    
    func generatePassTapped(passLength: Int, charSet: String) {
        let initialData = cipherTasks.retrieveInitialData()
//        print("Mi inicial data: \(initialData)")
        if initialData.key != "" {
            debugPrint("cardPass exists!!!")
            self.showDataView.sequenceKeyLbl.text = initialData.key
            self.showDataView.characterSetTV.text = initialData.charSet
            let cardArray = initialData.cardArray
            cardVC.customInitSymmetric(cardContent: cardArray)
            self.navigationController?.pushViewController(cardVC, animated: true)
            tabBarController?.selectedIndex = 1
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
        showDataView.generatePassBtn.isEnabled = true
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
        textView.layoutIfNeeded()
        self.initialCharacterSet = textView.text!
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layoutIfNeeded()
        self.editedCharacterSet = textView.text!
    }
    
}
