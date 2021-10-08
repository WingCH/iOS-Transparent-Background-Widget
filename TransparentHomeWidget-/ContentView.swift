//
//  ContentView.swift
//  TransparentHomeWidget-
//
//  Created by WingCH on 8/10/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
