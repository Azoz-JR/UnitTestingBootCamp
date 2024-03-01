//
//  UnitTestingBootCampViewModel_Tests.swift
//  UnitTesting_Tests
//
//  Created by Azoz Salah on 01/05/2023.
//

import XCTest
import Combine
@testable import UnitTesting


//Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
//Naming Structure: test_[struct or class]_[variable or function]_[expected result]
//Testing Structure: Given, When, Then

final class UnitTestingBootCampViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingBootCampViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootCampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestingBootCampViewModel_isPremium_shouldBeTrue() {
        //Given
        let userIsPremium: Bool = true
        
        //When
        let vm = UnitTestingBootCampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertTrue(vm.isPremium)
        
    }
    
    func test_UnitTestingBootCampViewModel_isPremium_shouldBeFalse() {
        //Given
        let userIsPremium: Bool = false
        
        //When
        let vm = UnitTestingBootCampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium)
        
    }
    
    func test_UnitTestingBootCampViewModel_isPremium_shouldBeInjectedValue() {
        //Given
        let userIsPremium: Bool = Bool.random()
        
        //When
        let vm = UnitTestingBootCampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
        
    }
    
    func test_UnitTestingBootCampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            //Given
            let userIsPremium: Bool = Bool.random()
            
            //When
            let vm = UnitTestingBootCampViewModel(isPremium: userIsPremium)
            
            //Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
        
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldBeEmpty() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldAddItems() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: String.random(length: Int.random(in: 1..<100)))
        }
        
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_dataArray_shouldNotAddBlankString() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldStartAsNil() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldBeNilWhenSelectedInvalidItem() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldBeSelected() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootCampViewModel_selectedItem_shouldBeSelected_stress() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)

        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootCampViewModel_saveItem_shouldThrowError_itemNotFound() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)

        }
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw Item Not Found") { error in
            let returnedError = error as? UnitTestingBootCampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootCampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootCampViewModel_saveItem_shouldThrowError_noData() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            
        }
        
        //Then
        do {
            try vm.saveItem(item: "")
        } catch {
            let returnedError = error as? UnitTestingBootCampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootCampViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingBootCampViewModel_saveItem_shouldSaveItem() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)

        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        //Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_UnitTestingBootCampViewModel_downloadWithEscaping_shouldReturnItems() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_downloadWithCombine_shouldReturnItems() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootCampViewModel_downloadWithCombine_shouldReturnItems2() {
        //Given
        let items = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
        let vm = UnitTestingBootCampViewModel(isPremium: Bool.random(), dataService: dataService)
        
        //When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
    
}




extension String {
    static func random(length: Int) -> Self {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
