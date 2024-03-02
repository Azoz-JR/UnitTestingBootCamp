//
//  Mockable.swift
//  YT-Vapor-iOS-AppTests
//
//  Created by Azoz Salah on 01/03/2024.
//

import Foundation


protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(filename: String, type: T.Type) -> [T]
}

extension Mockable {
    var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func loadJson<T: Decodable>(filename: String, type: T.Type) -> [T] {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Unable to find songs JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            
            let decodedObject = try JSONDecoder().decode([T].self, from: data)
            return decodedObject
        } catch {
            print("❌ \(error)")
            fatalError("Unable to decode Songs")
        }
    }
}
