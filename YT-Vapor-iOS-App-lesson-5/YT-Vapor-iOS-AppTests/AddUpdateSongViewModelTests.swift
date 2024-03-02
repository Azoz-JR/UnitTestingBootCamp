//
//  AddUpdateSongViewModelTests.swift
//  YT-Vapor-iOS-AppTests
//
//  Created by Azoz Salah on 01/03/2024.
//

import XCTest
@testable import YT_Vapor_iOS_App

final class AddUpdateSongViewModelTests: XCTestCase {

    var addUpdateSongVM: AddUpdateSongViewModel!
    
    override func setUp() {
        super.setUp()
        
        addUpdateSongVM = AddUpdateSongViewModel(httpClient: MockHTTPClient())
    }
    
    override func tearDown() {
        super.tearDown()
        addUpdateSongVM = nil
    }
    
    func testValidSong() {
        addUpdateSongVM.songTitle = "Sorry"
        
        XCTAssertTrue(addUpdateSongVM.isValidSong(), "Song's title mustn't be empty")
    }
    
    func testWhiteSpaceSongFails() {
        addUpdateSongVM.songTitle = "       "
        
        XCTAssertFalse(addUpdateSongVM.isValidSong(), "The song should not be valid.")
    }
}
