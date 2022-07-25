//
//  File.swift
//  
//
//  Created by Evandro Harrison Hoffmann on 15/12/2020.
//

import Foundation

public extension NSObject {
    func loadJSONData(file: String) -> Data? {
        guard let path = Bundle(for: type(of: self))
                .url(forResource: file, withExtension: "json") else { return nil }
        return try? Data(contentsOf: path)
    }
}

public extension Data {
    static func loadJSON(for file: String) -> Data? {
        guard let path = Bundle.module.url(forResource: file, withExtension: "json") else { return nil }
        return try? Data(contentsOf: path)
    }
}

import class Foundation.Bundle

private class BundleFinder {}

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var module: Bundle = {
        let bundleName = "MobileMagicUI_MobileMagicUI"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named MobileMagicUI_MobileMagicUI")
    }()
}
