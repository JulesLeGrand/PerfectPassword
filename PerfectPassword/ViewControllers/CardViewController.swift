//
//  CardViewController.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var delegate: CipherTasksDelegate?
    let cipherTasks = AESCipher()
    var cardArray = [String]()
    
    @IBOutlet weak var cardPassView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = cipherTasks
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("--> \(String(describing: type(of: self))), \(#function) - Line \(#line) > Hi!")
        cardPassView.collectionView.delegate = self
        cardPassView.collectionView.dataSource = self
        
        if let initialData = delegate?.retrieveInitialData() {
            if (initialData.cardArray.isEmpty) {
                debugPrint("CardArray is Empty")
                showAlert(message: "There are no data. Please return to Form Screen and tap \"New Sequence Key\" button")
            } else {
                debugPrint("CardArray have data")
                self.cardArray = initialData.cardArray
                DispatchQueue.main.async {
                    self.cardPassView.collectionView.reloadData()
                }
            }
        }
        
    }
        
    func customInitSymmetric(cardContent: [String]) {
        cardArray = cardContent
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController (title: "!Atention!", message: message, preferredStyle: .alert)
        let yes = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
}
