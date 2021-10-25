//
//  ContentViewModel.swift
//  TransparentHomeWidget-
//
//  Created by WingCH on 8/10/2021.
//

import Foundation
import SwiftUI
import WidgetKit
import Combine

class ContentViewModel: ObservableObject {
    
    let userDefaults =  UserDefaults(suiteName: groupId);
    
    @Published var selectedWidgetPosition: WidgetPosition {
        didSet {
            userDefaults?.set(selectedWidgetPosition.rawValue, forKey: userDefaultsWidgetPosition)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    // Save the image to AppStorage (UserDefaults), so that it can be used in widgets
    @Published var backgroundImage: Data? {
        didSet {
            userDefaults?.set(backgroundImage, forKey: userDefaultsSharedBackgroundImage)
        }
    }
    
    // Since extention cannot use `UIApplication.shared.windows` get safe area size, so save it for widgets
    @Published var safeAreaInsetTop: Double? {
        didSet {
            userDefaults?.set(safeAreaInsetTop, forKey: userDefaultsSharedSafeAreaInsetTop)
        }
    }
    
    let widgetFamilys: [WidgetFamily] = [
        WidgetFamily.systemSmall,
        WidgetFamily.systemMedium,
        WidgetFamily.systemLarge,
    ]
    
    @Published var widgetPositions: [WidgetPosition] = []
    
    @Published var selectedWidgetFamily = WidgetFamily.systemSmall
    
    @Published var isShowPhotoLibrary = false
    
    private var cancellable: AnyCancellable?
    
    
    init(){
        
//        if let selectedWidgetPositionRawValue = userDefaults?.object(forKey: userDefaultsWidgetPosition) as? String {
//            selectedWidgetPosition = WidgetPosition(rawValue: selectedWidgetPositionRawValue) ?? WidgetPosition.leftTop
//        }else{
//            selectedWidgetPosition = WidgetPosition.leftTop
//        }
        
         backgroundImage = userDefaults?.data(forKey: userDefaultsSharedBackgroundImage)
        
        // update available position list when widget family change
//        cancellable =  $selectedWidgetFamily.sink { widgetFamilys in
//            self.widgetPositions = WidgetPosition.availablePositions(widgetFamilys)
//        }
        
        // top safe area
        let window = UIApplication.shared.windows.first
        if let safeAreaPadding = window?.safeAreaInsets.top {
            safeAreaInsetTop = Double(safeAreaPadding)
        }
        
        selectedWidgetPosition = WidgetPosition.leftTop
        
        
        
    }
    
    func onClickSelectImage(){
        self.isShowPhotoLibrary = true
    }
    
    
    func onSelecedtImage(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            backgroundImage = data
        }
    }
}



