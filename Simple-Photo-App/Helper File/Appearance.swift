//
//  Appearance.swift
//  Simple-Photo-App
//
//  Created by Iyin Raphael on 5/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

enum Appearance {
    
    static let boldGrayColor = UIColor(red: 38/255.0, green: 50/255.0, blue: 56/255.0, alpha: 1.0)
    
    static func setTheme(_ color: UIColor) {
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    
}

extension UIViewController {
    func setUpAppearance() {
        view.backgroundColor = Appearance.boldGrayColor
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
