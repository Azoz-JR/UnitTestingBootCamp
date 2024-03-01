//
//  UnitTestingBootCampView.swift
//  UnitTesting
//
//  Created by Azoz Salah on 01/05/2023.
//

/*
 1. Unit Tests
 - test the business logic in your app
 
  2.UI Tests
 - test the UI
 */



import SwiftUI


struct UnitTestingBootCampView: View {
    
    @StateObject private var viewModel: UnitTestingBootCampViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingBootCampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

struct UnitTestingBootCampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootCampView(isPremium: true)
    }
}
