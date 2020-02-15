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
        self.removeActivityIndicator()
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
    
    func textViewDidChange(_ textView: UITextView) {
        guard let myText = textView.text else {
            return
        }
        if myText.contains("\n") || myText.contains("\r") || myText.contains(" ") {
            textView.text = filterSpacesAndCarrigeReturn(dirtyString: textView.text)
            let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
                self.showDataView.characterSetTV.text = self.editedCharacterSet
            }
            showAlert(message: "The characterSet cannot contain spaces or carriage return", actionOne: ok)
        }
        if myText.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            debugPrint("Cadena con solo espacios o nula")
            textView.text = initialCharacterSet
            let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
                self.showDataView.characterSetTV.text = self.initialCharacterSet
            }
            showAlert(message: "The characterSet cannot be empty", actionOne: ok)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layoutIfNeeded()
        self.editedCharacterSet = textView.text!
    }
    
}

extension ShowParametersViewController {
    
    func compareStrings() {
        if !validateCharacterSetLength(string: editedCharacterSet) {
            self.removeActivityIndicator()
            let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            }
            showAlert(message: "The character Set at least must contain 16 different characters", actionOne: ok)
        } else if initialCharacterSet != editedCharacterSet {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                self.removeActivityIndicator()
                self.showDataView.characterSetTV.text = self.initialCharacterSet
                self.navigationController?.popViewController(animated: true)
            }
            let yes = UIAlertAction(title: "Yes", style: .destructive) { (action) in
                self.inflatePassCard()
            }
            showAlert(message: "Are you sure to change the caracter set? All data will change...", actionOne: cancel, actionTwo: yes)
        }
    }
    
    func showAlert(message: String, actionOne: UIAlertAction, actionTwo: UIAlertAction) {
        let alert = UIAlertController (title: "!Atention!", message: message, preferredStyle: .alert)
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String, actionOne: UIAlertAction) {
        let alert = UIAlertController (title: "!Atention!", message: message, preferredStyle: .alert)
        alert.addAction(actionOne)
        present(alert, animated: true, completion: nil)
    }
    
    func validateCharacterSet(textView: String) -> Bool {
        var result = true
        if textView.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            debugPrint("Cadena con solo espacios o nula")
            result = false
        }
        return result
    }
    
    func validateCharacterSetLength(string: String) -> Bool {
        var result = true
        if string.count < 16 {
            result = false
        }
        return result
    }
    
    func filterSpacesAndCarrigeReturn(dirtyString: String) -> String {
        let cleanString = String(dirtyString.filter { !" \n\t\r".contains($0) })
        return cleanString
    }
    
    func showActivityIndicator() {
        myView = UIView(frame: self.view.bounds)
        myView?.backgroundColor = UIColor.init(red: 75/255, green: 75/255, blue: 75/255, alpha: 0.6)
        myActivityIndicator.center = self.view.center
        myView?.addSubview(myActivityIndicator)
        self.view.addSubview(myView!)
        myActivityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        self.myView?.removeFromSuperview()
        self.myView = nil
    }
}
