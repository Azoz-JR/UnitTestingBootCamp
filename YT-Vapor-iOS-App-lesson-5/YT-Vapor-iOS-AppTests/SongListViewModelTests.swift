//
//  SongListViewModelTests.swift
//  YT-Vapor-iOS-AppTests
//
//  Created by Azoz Salah on 01/03/2024.
//

import Combine
import XCTest
@testable import YT_Vapor_iOS_App

final class SongListViewModelTests: XCTestCase {

    var songListVM: SongListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    
    override func setUp() {
        super.setUp()
        
        songListVM = SongListViewModel(httpClient: MockHTTPClient())
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        
        songListVM = nil
        cancellables = []
    }
    
    func testFetchSongsSuccessfully() async throws {
        //let expectation = XCTestExpectation(description: "Fetched Songs")
        
        try await songListVM.fetchSongs()
//        
//        songListVM
//            .$songs
//            .sink { value in
//                XCTAssertEqual(value.count, 2)
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//        
//        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(songListVM.songs.count, 2)
    }

}
