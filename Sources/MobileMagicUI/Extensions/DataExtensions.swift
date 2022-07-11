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
