//
//  UnitTestingBootCampViewModel.swift
//  UnitTesting
//
//  Created by Azoz Salah on 01/05/2023.
//

import Foundation
import SwiftUI
import Combine


class UnitTestingBootCampViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    let dataService: NewDataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: {$0 == item}) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: {$0 == item}) {
            print("Save it here!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
        
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] items in
                self?.dataArray = items
            }
            .store(in: &cancellables)

    }
    
}
