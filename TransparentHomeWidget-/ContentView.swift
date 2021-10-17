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
            Image(uiImage: (self.viewModel.bg == nil ? UIImage() : UIImage(data: self.viewModel.bg!))!)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Picker("選擇", selection: self.$viewModel.selectedWidgetFamily) {
                    ForEach(self.viewModel.widgetFamilys, id: \.self) { (index) in
                        Text(self.viewModel.widgetFamilys[index.rawValue].description)
                       }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 300, height: 300)

                Picker("選擇", selection: self.$viewModel.selectedWidgetPosition) {
                    ForEach(self.viewModel.widgetPositions, id: \.self) { (widgetPosition) in
                        Text(String(describing: widgetPosition))
                       }
                    
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 300, height: 300)

                
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
            
            
        }
        .sheet(isPresented: self.$viewModel.isShowPhotoLibrary) {
            ImagePicker(selectedImage: viewModel.onSelectImage, sourceType: .photoLibrary)
        }
        .statusBar(hidden: self.viewModel.bg == nil ? false : true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
