//
//  ShowParametersViewController.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

class ShowParametersViewController: UIViewController {
    
//    let storyBoard = UIStoryboard(name: <#T##String#>, bundle: <#T##Bundle?#>)
    
    var delegate: HandleDataDelegate?
    let dataManagement = DataManagement()
    let cardVC = CardViewController()
    
    @IBOutlet weak var showDataView: ShowData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = dataManagement
        setupController()
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
    }

}