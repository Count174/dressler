//
//  Color+.swift
//  hwtdrss
//
//  Created by Johnnie Walker on 18.11.2022.
//

import SwiftUI

extension Color {
    /**
     Initializer supporting two types of HEX color designations - RGB and RGBA. The HEX-code must start with the `#` symbol

     Note that for an 8-diggit HEX, the transparency designator must be a couple of characters at the end of the code.
     
     If the alpha parameter is passed for an 8 character code, then it will be considered a priority when calculating the color.
     
     ```
     UIColor(hex: "#35c759") // green color without opacity
     UIColor(hex: "#35c759", alpha: 0.9) // green color with opacity 90%
     
     UIColor(hex: "#35c75966") // green color with opacity 40%
     UIColor(hex: "#35c75966", alpha: 0.9) // green color with opacity 90%
     ```
     */
    init?(hex: String, alpha: CGFloat? = nil) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if hexColor.count == 6 {
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000FF) / 255

                    self.init(uiColor: .init(red: r, green: g, blue: b, alpha: alpha ?? 1))
                    return
                }
            } else if hexColor.count == 8 {
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000FF) / 255

                    self.init(uiColor: .init(red: r, green: g, blue: b, alpha: alpha ?? a))
                    return
                }
            }
        }

        return nil
    }
}
