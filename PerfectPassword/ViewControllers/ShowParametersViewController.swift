//
//  ShowParametersViewController.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

class ShowParametersViewController: UIViewController {
    
    var delegate: HandleDataDelegate?
    let dataManagement = DataManagement()
    
    var delegateChiper: CipherTasksDelegate?
    let cipherTasks = AESCipher()
    
    let cardVC = CardViewController()
    
    var initialCharacterSet = ""
    var editedCharacterSet = ""
    
    @IBOutlet weak var showDataView: ShowData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = dataManagement
        self.delegateChiper = cipherTasks
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let initialData = delegate?.retrieveInitialData() {
            if initialData.key != "" {
    //           print("DEsde viewWillAppear_ShowParametersViewController \(initialData)")
                debugPrint("--> \(String(describing: type(of: self))), \(#function) - Line \(#line) > We have initial Data!")
                showDataView.passcodeLengthLbl.text = String(initialData.passLength)
                showDataView.sequenceKeyLbl.text = initialData.key
                showDataView.characterSetTV.text = initialData.charSet
            } else {
                debugPrint("--> \(String(describing: type(of: self))), \(#function) - Line \(#line) > No initial Data my friend!")
                showDataView.sequenceKeyLbl.text = "There are no data yet, please get a new sequence key"
                showDataView.generatePassBtn.isEnabled = false
                showDataView.generatePassBtn.setTitleColor(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.1), for: .disabled)
            }
        }
    }
    
    func setupController() {
        showDataView.mDelegate = self
        showDataView.characterSetTV.delegate = self
        setupTextView()
    }
    
    
    
    func setupTextView() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 90)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnAction))
        
        toolbar.setItems([space, doneBtn], animated: true)
        toolbar.sizeToFit()
        
        showDataView.characterSetTV.inputAccessoryView = toolbar
    }
    
    func updateKeyView (key: String) {
        showDataView.sequenceKeyLbl.text = key
    }
    
    @objc func doneBtnAction() {
        self.view.endEditing(true)
        compareStrings()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    func compareStrings() {
        if !validateCharacterSet(textView: editedCharacterSet) {
            // Empty field or with only spaces
            debugPrint("In validateCharacterSet condition")
            let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
                self.showDataView.characterSetTV.text = self.initialCharacterSet
            }
            showAlert(message: "The characterSet cannot be empty", actionOne: ok)
        } else if editedCharacterSet.contains("\n") || editedCharacterSet.contains("\r") || editedCharacterSet.contains(" ") {
            editedCharacterSet = filterSpacesAndCarrigeReturn(dirtyString: editedCharacterSet)
            let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
                self.showDataView.characterSetTV.text = self.editedCharacterSet
            }
            showAlert(message: "The characterSet cannot contain spaces or carriage return", actionOne: ok)
        } else if !validateCharacterSetLength(string: editedCharacterSet) {
            let ok = UIAlertAction(title: "Ok", style: .destructive) { (action) in
                self.showDataView.characterSetTV.text = self.initialCharacterSet
            }
            showAlert(message: "The character Set at least must contain 16 different characters", actionOne: ok)
        } else if initialCharacterSet != editedCharacterSet {
            //The Strings are diferent
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
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
//        debugPrint(cleanString)
        return cleanString
    }

}
