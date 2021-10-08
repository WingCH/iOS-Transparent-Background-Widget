//
//  ContentViewModel.swift
//  TransparentHomeWidget-
//
//  Created by WingCH on 8/10/2021.
//

import Foundation
import UIKit
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var isShowPhotoLibrary = false
    
    // Save the image to AppStorage (UserDefaults), so that it can be used in widgets
    @AppStorage("widgetBg") var widgetBg: Data?

    init(){}
    
    func onSelectImage(image: UIImage){
        if let data = image.pngData() {
            widgetBg = data
        }
    }
}
