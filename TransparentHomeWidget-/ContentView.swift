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
        ZStack(alignment: .bottom) {
            Image(uiImage: self.viewModel.image ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                self.viewModel.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding()
            }
        }
        .sheet(isPresented: self.$viewModel.isShowPhotoLibrary) {
            ImagePicker(selectedImage: self.$viewModel.image, sourceType: .photoLibrary)
        }
        .statusBar(hidden: self.viewModel.image == nil ? false : true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
