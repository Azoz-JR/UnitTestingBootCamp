//
//  MockHTTPClient.swift
//  YT-Vapor-iOS-AppTests
//
//  Created by Azoz Salah on 01/03/2024.
//

import Foundation
@testable import YT_Vapor_iOS_App


class MockHTTPClient: HTTPClientProtocol, Mockable {
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        return loadJson(filename: "SongResponse", type: T.self)
    }
    
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        
    }
    
    func delete(at id: UUID, url: URL) async throws {
        
    }
}
