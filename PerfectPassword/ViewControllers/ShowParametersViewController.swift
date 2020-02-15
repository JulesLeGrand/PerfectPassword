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
    var myView: UIView?
    let myActivityIndicator = UIActivityIndicatorView(style: .large)
    
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
        self.showActivityIndicator()
        compareStrings()
    }
}
