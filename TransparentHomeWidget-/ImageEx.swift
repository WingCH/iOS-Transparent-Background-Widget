//
//  ImageHelper.swift
//  TransparentHomeWidget-
//
//  Created by WingCH on 9/10/2021.
//

import Foundation
import UIKit
import DeviceKit

// https://stackoverflow.com/a/56231006/5588637
extension UIImage
{
    func cropToWidgetSize(
        safeAreaInsetTop: Double,
        width: Double,
        height: Double
    )-> UIImage{
        
        // screen size
        let screenSize: CGRect = UIScreen.main.bounds

        
        // use for calculate pt to px
        let scale = UIScreen.main.scale
        print(screenSize)
        print(scale)
        let leftMargin = screenSize.width / 15;
        let topMargin = Device.current.hasSensorHousing ? 30.0 : 10.0;
        
        let smallWidgetWidth = width;
        let smallWidgetHeight = height;
        
        let cropArea = CGRect(
            x: leftMargin * scale,
            y: (safeAreaInsetTop + topMargin) * scale,
            width: smallWidgetWidth * scale,
            height: smallWidgetHeight * scale
        )
        
        let cropedImage = self.cropImage(toRect: cropArea)
        
        return cropedImage;
    }
    
    func cropImage( toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = self.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
}
