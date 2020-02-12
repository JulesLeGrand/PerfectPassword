//
//  CardView.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    let nibName = "CardView"
    var contentView: UIView?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
        {
        didSet {
//            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            debugPrint("El minimumInteritemSpacing -> \(collectionLayout.minimumInteritemSpacing)")
            collectionLayout.minimumInteritemSpacing = 0
//            debugPrint("El minimumLineSpacing -> \(collectionLayout.minimumLineSpacing)")
            collectionLayout.minimumLineSpacing = 0
            collectionLayout.scrollDirection = .vertical
            collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        initCollectionView()
    }
    
    func initCollectionView() {
        let nib = UINib (nibName: "CustomCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCell")
    }
    
}
