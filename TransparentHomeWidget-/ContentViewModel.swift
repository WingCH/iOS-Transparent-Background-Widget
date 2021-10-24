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
    
    let userDefaults =  UserDefaults(suiteName: "group.com.keep-learning.TransparentHomeWidget");
    
    @Published var selectedWidgetPosition: WidgetPosition {
        didSet {
            userDefaults?.set(selectedWidgetPosition.rawValue, forKey: "widgetPosition")
        }
    }
    
    // Save the image to AppStorage (UserDefaults), so that it can be used in widgets
    @Published var backgroundImage: Data? {
        didSet {
            userDefaults?.set(backgroundImage, forKey: "backgroundImage")
        }
    }
    
    // Since extention cannot use `UIApplication.shared.windows` get safe area size, so save it for widgets
    @Published var safeAreaInsetTop: Double? {
        didSet {
            userDefaults?.set(safeAreaInsetTop, forKey: "safeAreaInsetTop")
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
        
        if let selectedWidgetPositionRawValue = userDefaults?.object(forKey: "widgetPosition") as? String {
            selectedWidgetPosition = WidgetPosition(rawValue: selectedWidgetPositionRawValue) ?? WidgetPosition.leftTop
        }else{
            selectedWidgetPosition = WidgetPosition.leftTop
        }
        
         backgroundImage = userDefaults?.data(forKey: "backgroundImage")
        
        // update available positions
        cancellable =  $selectedWidgetFamily.sink { widgetFamilys in
            self.widgetPositions = WidgetPosition.availablePositions(widgetFamilys)
        }
        
        // top safe area
        let window = UIApplication.shared.windows.first
        if let safeAreaPadding = window?.safeAreaInsets.top {
            safeAreaInsetTop = Double(safeAreaPadding)
        }
        
        
    }
    
    func onClickSelectImage(){
        self.isShowPhotoLibrary = true
    }
    
    
    func onSelecedtImage(image: UIImage){
        if let data = image.pngData() {
            backgroundImage = data
        }
    }
}



