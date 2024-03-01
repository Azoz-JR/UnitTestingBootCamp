//
//  CWCUnitTestingTests.swift
//  CWCUnitTestingTests
//
//  Created by Azoz Salah on 01/03/2024.
//

import XCTest
@testable import CWCUnitTesting

final class CWCUnitTestingTests: XCTestCase {
    var simpleMaths: SimpleMaths!
    
    
    override func setUp() {
        simpleMaths = SimpleMaths()
    }
    
    
    override func tearDown() {
        simpleMaths = nil
    }
    
    func test_AddTen_Works() {
        // Given
        var expected = 0
        
        // When
        expected = simpleMaths.addTen(number: 10)
        
        // Then
        XCTAssertEqual(expected, 20)
    }
    
    func test_beSquare_Succeds() {
        // Given
        var expected = 0
        
        // When
        expected = simpleMaths.beSquare(4)
        
        // Then
        XCTAssertEqual(expected, 16)
    }
    

}
