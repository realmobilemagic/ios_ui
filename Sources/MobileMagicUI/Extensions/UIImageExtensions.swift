//
//  UIImageExtensions.swift
//  
//
//  Created by Evandro Harrison Hoffmann on 16/12/2020.
//

import UIKit

public extension String {
    var uiImage: UIImage? {
        uiImage(in: nil, with: nil)
    }
    
    func uiImage(in bundle: Bundle? = nil, with configuration: UIImage.Configuration? = nil) -> UIImage? {
        UIImage(named: self, in: bundle, with: configuration)!
    }
    
    func uiImage(_ renderingMode: UIImage.RenderingMode, in bundle: Bundle? = nil, with configuration: UIImage.Configuration? = nil) -> UIImage? {
        uiImage(in: bundle, with: configuration)?.withRenderingMode(renderingMode)
    }
    
    func templateImage(in bundle: Bundle? = nil, with configuration: UIImage.Configuration? = nil) -> UIImage? {
        uiImage(.alwaysTemplate, in: bundle, with: configuration)
    }
}

extension UIImage{
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
