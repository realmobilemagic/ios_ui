//
//  File.swift
//  
//
//  Created by Evandro Harrison Hoffmann on 14/12/2020.
//

import UIKit

public extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        var hexWithPrefix = hex
        if !hexWithPrefix.hasPrefix("#") {
            hexWithPrefix = "#\(hexWithPrefix)"
        }
        
        let start = hexWithPrefix.index(hexWithPrefix.startIndex, offsetBy: 1)
        let hexColor = String(hexWithPrefix[start...])
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        switch hexColor.count {
        case 8:
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        case 6:
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            a = 1
        case 3:
            r = CGFloat((hexNumber & 0xf00) >> 16) / 255
            g = CGFloat((hexNumber & 0x0f0) >> 8) / 255
            b = CGFloat(hexNumber & 0x00f) / 255
            a = 1
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }
        return self
    }
    
    var noSaturation: UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        return UIColor(hue: h, saturation: 0, brightness: b, alpha: a)
    }
    
    var saturated: UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        return UIColor(hue: h, saturation: 1.0, brightness: b, alpha: a)
    }
    
    var bright: UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        return UIColor(hue: h, saturation: s, brightness: 1.0, alpha: a)
    }
    
    var dark: UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        return UIColor(hue: h, saturation: s, brightness: 0, alpha: a)
    }
    
    // Check if the color is light or dark, as defined by the injected lightness threshold.
    // Some people report that 0.7 is best. I suggest to find out for yourself.
    // A nil value is returned if the lightness couldn't be determined.
    func isLight(threshold: Float = 0.7) -> Bool? {
        let originalCGColor = self.cgColor
        
        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }
        
        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
}

public extension String {
    var color: UIColor? { UIColor(named: self) ?? UIColor(hex: self) }
    var cgColor: CGColor? { color?.cgColor }
}

public extension UIImage {
    static func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

public extension UIColor {
    var image: UIImage { UIImage.image(with: self) }
}

public extension UIColor {
    static var random: UIColor {
        UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    static var randomRGBA: (r: Double, g: Double, b: Double, a: Double) {
        (r: .random(in: 0...1), g: .random(in: 0...1), b: .random(in: 0...1), a: 1)
    }
}
