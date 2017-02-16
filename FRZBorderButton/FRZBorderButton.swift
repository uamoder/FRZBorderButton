//
//  FRZBorderButton.swift
//  FRZBorderButton
//
//  Created by Alex Neminsky on 29.01.17.
//  Copyright © 2017 SkaKot. All rights reserved.
//

import UIKit

@IBDesignable class FRZBorderButton: UIButton {
    
    fileprivate struct FRZButtonParameters {
        let text: String
        let color: UIColor
    }
    
    enum FRZBorderButtonType: String {
        case defaultType = "default"
        case cancelType = "cancel"
        case previewType = "preview"
        case nextType = "next"
        case doneType = "done"
        case editType = "edit"
    }
    
    private let parameters: [FRZBorderButtonType: FRZButtonParameters] = [
        .defaultType : FRZButtonParameters(text: "", color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),
        .cancelType : FRZButtonParameters(text: NSLocalizedString("Cancel", comment: ""), color: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)),
        .previewType : FRZButtonParameters(text: NSLocalizedString("← Back", comment: ""), color: #colorLiteral(red: 1, green: 0.3535359502, blue: 0.4449678957, alpha: 1)),
        .nextType : FRZButtonParameters(text: NSLocalizedString("Next →", comment: ""), color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
        .doneType : FRZButtonParameters(text: NSLocalizedString("Done!", comment: ""), color: #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)),
        .editType : FRZButtonParameters(text: NSLocalizedString("Edit", comment: ""), color: #colorLiteral(red: 0.9534236789, green: 1, blue: 0.4017472267, alpha: 1)),
    ]
    
    var myButtonType: FRZBorderButtonType = .defaultType { didSet { setData() } }
    
    private var currentParameters: FRZButtonParameters! {
        return parameters[myButtonType]
    }
    
    //MARK: - @IBInspectable
    @IBInspectable var customColor: UIColor? { didSet { setData() } }
    @IBInspectable var borderWidth: CGFloat = 1.0 { didSet { setData() } }
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'myButtonType' instead.")
    @IBInspectable var buttonTypeName: String? {
        willSet {
            if let newMyButtonType = FRZBorderButtonType (rawValue: newValue?.lowercased() ?? "default") {
                myButtonType = newMyButtonType
            }
        }
    }
    
    //MARK: - methods
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupInterface()
        setData()
    }
    
    func setupInterface() {
        layer.cornerRadius = bounds.size.height / 2
        clipsToBounds = true
        titleLabel?.textAlignment = .center
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
    }
    
    func setData() {
        
        let color = customColor ?? currentParameters.color

        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
        
        if let label = titleLabel {
            self.setTitleColor(color, for: .normal)
            if currentParameters.text != "" {
                label.text = currentParameters.text
            }
        }
        
    }

}
