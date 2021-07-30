//
//  String.swift
//  percy
//
//  Created by Антон Усов on 29.07.2021.
//

import UIKit

extension String {
    
    // в зависимости от текста разная ширина CollectionViewCell
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        
        return ceil(size.width)
    }
    
}

