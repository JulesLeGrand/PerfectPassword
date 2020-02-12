//
//  ExtensionCardView.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/10/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import Foundation
import UIKit

extension CardViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            fatalError()
        }
        
        debugPrint("El ancho de la celda es -> \(cell.frame.size.width)")
        debugPrint("El ancho del collection es -> \(collectionView.frame.size.width/3)")
        debugPrint("El ancho de la pantalla es -> \(view.frame.size.width)")
        cell.cellLabel.text = cardArray[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.size.width
        let numberOfColumns = 11
        let dimensions = CGFloat(Int(totalWidth) / numberOfColumns)
        return CGSize(width: dimensions, height: dimensions)
    }
    
}
