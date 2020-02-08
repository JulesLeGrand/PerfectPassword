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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("En viewWillAppear")
        //TODO: Preguntar si existen datos guardados para mostrar la tarjeta
    }
    
//    func customInit(myInputData: InputData) {
//        self.delegate = cipherTasks
//        let cardArray: [String] = (self.delegate?.getCard(inputData: myInputData))!
//        print(cardArray)
//    }
    
    func customInitSymmetric(cardContent: [String]) {
        debugPrint(cardContent)
    }

}
