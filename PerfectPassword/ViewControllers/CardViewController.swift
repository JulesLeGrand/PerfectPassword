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
        fillTestArray()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
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
                self.cardArray = initialData!.cardArray
            }
        
        
    }
        
    func customInitSymmetric(cardContent: [String]) {
        debugPrint("DEsde customInitSymmetric \(cardContent)")
    }
    

    
    func fillTestArray() {
//        let inicio = 123456789101213
//        let inicio = 1234
        let inicio = 10
        for i in inicio ... (inicio + 109) {
            cardArray.append(String(i))
        }
        print(cardArray)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

}
