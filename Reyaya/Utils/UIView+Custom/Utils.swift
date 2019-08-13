//
//  Utils.swift
//  The Avenue Agent
//
//  Created by Peter Bassem on 5/11/18.
//  Copyright © 2018 Ashraf Essam. All rights reserved.
//

import Foundation
import UIKit
//import NVActivityIndicatorView
//import Kingfisher

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}


//MARK: - UIViewController Extension
extension UIViewController {
    
    //MARK:- Functions
    
    func setNavigationBarItems(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.barTintColor =  COLORS.mainColor
        navigationController?.navigationBar.tintColor = COLORS.navigationBarTintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: setFont(size: 22.0, isBold: false) ,NSAttributedString.Key.foregroundColor: COLORS.navigationBarTitleTextAttributes]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: COLORS.navigationBarTitleTextAttributes]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setFont(size fontSize: CGFloat, isBold bold: Bool) -> UIFont {
        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
            return UIFont(name: bold ? "Bariol-Bold" : "Bariol-Regular", size: fontSize)!
        } else {
            return UIFont(name: bold ? "NotoKufiArabic-Bold" : "NotoKufiArabic", size: (fontSize - 2.0))!
        }
    }
}

////MARK: - UIView Extension

extension UIView {
    func setFont(size fontSize: CGFloat, isBold bold: Bool) -> UIFont {
        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
            return UIFont(name: bold ? "Bariol-Bold" : "Bariol-Regular", size: fontSize)!
        } else {
            return UIFont(name: bold ? "NotoKufiArabic-Bold" : "NotoKufiArabic", size: (fontSize - 2.0))!
        }
    }
}

//MARK: - UIButton Extension
extension UIButton {
    
    func moveImageLeftTextCenter(image : UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderingMode), for: .normal)
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        let imageLeft = imagePadding - imageViewWidth / 2
        let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageLeft, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft , bottom: 0.0, right: 0.0)
    }
    
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        if UIDevice.modelName.contains("5") {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width/7 , bottom: 0, right: self.frame.width/7)
        } else {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width/4 , bottom: 0, right: self.frame.width/4)
        }
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.setImage(image.withRenderingMode(renderMode), for: UIControl.State.normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: image.size.width / 2)
        self.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }

    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        if UIDevice.modelName.contains("5") {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width/8 , bottom: 0, right: self.frame.width/8)
        } else {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width/5 , bottom: 0, right: self.frame.width/5)
        }
        self.setImage(image.withRenderingMode(renderMode), for: UIControl.State.normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: image.size.width / 2, bottom: 0, right: 16)
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        self.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
}

//MARK: - UIColor Extension
extension UIColor {
    
    convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (0, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    convenience init(rgbValue:UInt32, alpha:Double=1.0) {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
//        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha))
    }
}

//MARK: - UIDevice Extension
public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
