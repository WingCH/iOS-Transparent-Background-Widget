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
    @Published var image: UIImage?
    
    init(){
        
    }
}
