//
//  Colors.swift
//  FindIt!
//
//  Created by Christos Petrou on 05/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    static let GreeceBlue = UIColor(hex: 0x0D5EAF)
    static let CyprusOrange = UIColor(hex: 0xD47600)
    static let FindBlue = UIColor(hex: 0x0C74DA)
    static let FindOrange = UIColor(hex: 0xD47600)
    
    static let BlueBuzzerColor = UIColor(hex: 0x1656C7)
    static let YellowBuzzerColor = UIColor(hex: 0xFFEB07)
    static let GreenBuzzerColor = UIColor(hex: 0x48A62A)
    static let RedBuzzerColor = UIColor(hex: 0xDE1E03)
}
