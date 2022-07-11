//
//  File.swift
//  
//
//  Created by Evandro Harrison Hoffmann on 15/12/2020.
//

import Foundation

extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data?) throws -> Self {
        guard let data = data else {
            throw CodableError.invalidData
        }
        
        return try decoder.decode(Self.self, from: data)
    }
    
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data?) throws -> [Self] {
        guard let data = data else {
            throw CodableError.invalidData
        }
        
        return try decoder.decode([Self].self, from: data)
    }
}

enum CodableError: Error {
    case invalidData
}
