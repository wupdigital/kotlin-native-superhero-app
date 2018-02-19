//
//  PaddedLabel.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 19..
//  Copyright © 2018. W.UP. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    var textContentInset = CGRect.zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: textContentInset.origin.y,
                                       left: textContentInset.origin.x,
                                       bottom: textContentInset.size.height,
                                       right: textContentInset.size.width)

        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
