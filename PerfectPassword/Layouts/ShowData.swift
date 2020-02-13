//
//  ShowData.swift
//  PerfectPassword
//
//  Created by Ago Moviles on 2/3/20.
//  Copyright © 2020 Julio. All rights reserved.
//

import UIKit

@IBDesignable
class ShowData: UIView {
    
//    var inputData: InputData?
    
    @IBOutlet weak var sequenceKeyLbl: UILabel!
    @IBOutlet weak var passcodeLengthLbl: UILabel!
    @IBOutlet weak var characterSetTV: UITextView!
    @IBOutlet weak var newSequenceBtn: UIButton!
    @IBOutlet weak var generatePassBtn: UIButton!
    
    var mDelegate: FormUIEventsDelegate?
    let nibName = "ShowData"
    var contentView: UIView?
    
    @IBAction func newSequenceTap(_ sender: Any) {
        mDelegate?.newSequenceTapped()
    }
    
    @IBAction func generatePassTap(_ sender: Any) {
        if let passcodeLength = passcodeLengthLbl?.text, let characterSet = characterSetTV.text {
            mDelegate?.generatePassTapped(passLength: Int(passcodeLength)!, charSet: characterSet)
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
        passcodeLengthLbl.text = String(11)
    }
    
    
    
}
