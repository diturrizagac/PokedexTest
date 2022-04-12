//
//  UIView+Extension.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 11/04/22.
//

import UIKit

extension UIView {
    func dropShadowEffect() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.cornerRadius = 11
    }
}
