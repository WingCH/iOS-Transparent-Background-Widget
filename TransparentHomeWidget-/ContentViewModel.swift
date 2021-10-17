//
//  ContentViewModel.swift
//  TransparentHomeWidget-
//
//  Created by WingCH on 8/10/2021.
//

import Foundation
import SwiftUI
import WidgetKit

class ContentViewModel: ObservableObject {
    
    var widgetFamilys: [WidgetFamily] = [
        WidgetFamily.systemSmall,
        WidgetFamily.systemMedium,
        WidgetFamily.systemLarge,
    ]
    
    var widgetPositions: [WidgetPosition] = []
    
    @Published var selectedWidgetFamily = WidgetFamily.systemSmall {
        didSet {
            widgetPositions = WidgetPosition.availablePositions(selectedWidgetFamily)
        }
    }
    @Published var selectedWidgetPosition = WidgetPosition.leftTop
    
    @Published var isShowPhotoLibrary = false
    
    // Save the image to AppStorage (UserDefaults), so that it can be used in widgets
    @AppStorage("bg",  store: UserDefaults(suiteName: "group.com.keep-learning.TransparentHomeWidget")) var bg: Data?
    // Since extention cannot use `UIApplication.shared.windows` get safe area size, so save it for widgets
    @AppStorage("safeAreaInsetTop",  store: UserDefaults(suiteName: "group.com.keep-learning.TransparentHomeWidget")) var safeAreaInsetTop: Double?
    
    init(){
        
        widgetPositions = WidgetPosition.availablePositions(selectedWidgetFamily)
        
        // top safe area
        let window = UIApplication.shared.windows.first
        if let safeAreaPadding = window?.safeAreaInsets.top {
            safeAreaInsetTop = Double(safeAreaPadding)
        }
        
        //        let originalImage = UIImage(named: "screenshot")
        //        let cropedImage = originalImage?.cropToWidgetSize(safeAreaInsetTop: safeAreaPadding!, width: 158, height: 158)
        //        print(cropedImage)
    }
    
    func onSelectImage(image: UIImage){
        if let data = image.pngData() {
            bg = data
        }
    }
}



