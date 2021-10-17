//
//  ImageHelper.swift
//  TransparentHomeWidget-
//
//  Created by WingCH on 9/10/2021.
//

import Foundation
import UIKit
import WidgetKit
//import DeviceKit

// https://stackoverflow.com/a/56231006/5588637
extension UIImage
{
    // iPhone 13 Pro
    // useful size resource: https://www.screensizes.app/
    func cropToWidgetSize(
        safeAreaInsetTop: Double,
        widgetSize: CGSize,
        widgetPosition: WidgetPosition
    )-> UIImage{
        
        // screen size
//        let screenSize: CGRect = UIScrescreenSizeen.main.bounds
        
        // use for calculate pt to px
        // iPhone 13 Pro: 390 x 844 -> 1170 x 2532
        let scale = UIScreen.main.scale
        
        // let topMargin = Device.current.hasSensorHousing ? 30.0 : 10.0;
        // status Bar height
        let statusBarHeight = safeAreaInsetTop;
        let topMargin = 30.0;
        let leftMargin = 25.0;
        let verticalMargin: CGFloat = 23;
        let horizontalMargin: CGFloat = 38.2;
        
        var startPoint: CGPoint = CGPoint(x: leftMargin, y: (topMargin + statusBarHeight));
        
        
        switch widgetPosition {
        case .top:
            startPoint.x += 0;
        case .leftTop:
            startPoint.x += 0;
        case .rightTop:
            startPoint.x += (widgetSize.width + verticalMargin);
        case .middle:
            break
        case .leftMiddle:
            startPoint.x += 0;
            startPoint.y += (widgetSize.height + horizontalMargin);
            break
        case .rightMiddle:
            startPoint.x += (widgetSize.width + verticalMargin);
            startPoint.y += (widgetSize.height + horizontalMargin);
            break
        case .bottom:
            break
        case .leftBottom:
            startPoint.x += 0;
            startPoint.y += (widgetSize.height + horizontalMargin) * 2;
            break
        case .rightBottom:
            break
        }
        
        
        let cropArea = CGRect(
            x: startPoint.x * scale,
            y: startPoint.y * scale,
            width: widgetSize.width * scale,
            height: widgetSize.height * scale
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

// Only Tested in iPhone
enum WidgetPosition {
    
    case top
    case leftTop
    case rightTop
    
    case middle
    case leftMiddle
    case rightMiddle
    
    case bottom
    case leftBottom
    case rightBottom
    
    static func availablePositions(_ widgetFamily: WidgetFamily) -> [WidgetPosition] {
        switch widgetFamily {
        case .systemSmall:
            return [leftTop, rightTop, leftMiddle, rightMiddle, leftBottom, rightBottom]
        case .systemMedium:
            return [top, middle, bottom]
        case .systemLarge:
            return [top, bottom]
        case .systemExtraLarge:
            fatalError("Not yet implemented")
        @unknown default:
            fatalError("Not yet implemented")
        }
    }
}



