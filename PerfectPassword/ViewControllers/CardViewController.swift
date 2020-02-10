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
        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("En viewWillAppear")
        cardPassView.collectionView.delegate = self
        cardPassView.collectionView.dataSource = self
        //TODO: Preguntar si existen datos guardados para mostrar la tarjeta
        let initialData = delegate?.retrieveInitialData()
            if (initialData?.cardArray.isEmpty)! {
                debugPrint("Esta vacio el arreglo de card")
            } else {
//                cardPassView.collectionView.reloa
                self.cardArray = initialData!.cardArray
            }
        
        
    }
        
    func customInitSymmetric(cardContent: [String]) {
        debugPrint("DEsde customInitSymmetric \(cardContent)")
    }
    
    func initCollectionView() {
        let nib = UINib (nibName: "CustomCell", bundle: nil)
        cardPassView.collectionView.register(nib, forCellWithReuseIdentifier: "CustomCell")
    }

}
