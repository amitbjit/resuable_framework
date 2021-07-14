//
//  UIImage+extension.swift
//  ARCHECO KDDI HTB
//
//  Created by Archeco_ipad on 23/3/20.
//  Copyright © 2020 Archeco. All rights reserved.
//

import UIKit

public enum ImageGradientDirection {
    case toLeft
    case toRight
    case toTop
    case toBottom
    case toBottomLeft
    case toBottomRight
    case toTopLeft
    case toTopRight
}

public extension UIImage {
    
    func fixImageOrientation() -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }

    convenience init?(size: CGSize, direction: ImageGradientDirection, colors: [UIColor]) {
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

            guard let context = UIGraphicsGetCurrentContext() else { return nil } // If the size is zero, the context will be nil.

            guard colors.count >= 1 else { return nil } // If less than 1 color, return nil

            if colors.count == 1 {
                // Mono color
                let color = colors.first!
                color.setFill()

                let rect = CGRect(origin: CGPoint.zero, size: size)
                UIRectFill(rect)
            }
            else {
                // Gradient color
                var location: CGFloat = 0
                var locations: [CGFloat] = []

                for (index, _) in colors.enumerated() {
                    let index = CGFloat(index)
                    locations.append(index / CGFloat(colors.count - 1))
                }

                guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colors.compactMap { $0.cgColor.components }.flatMap { $0 }, locations: locations, count: colors.count) else {
                    return nil
                }

                var startPoint: CGPoint
                var endPoint: CGPoint

                switch direction {
                case .toLeft:
                    startPoint = CGPoint(x: size.width, y: size.height/2)
                    endPoint = CGPoint(x: 0.0, y: size.height/2)
                case .toRight:
                    startPoint = CGPoint(x: 0.0, y: size.height/2)
                    endPoint = CGPoint(x: size.width, y: size.height/2)
                case .toTop:
                    startPoint = CGPoint(x: size.width/2, y: size.height)
                    endPoint = CGPoint(x: size.width/2, y: 0.0)
                case .toBottom:
                    startPoint = CGPoint(x: size.width/2, y: 0.0)
                    endPoint = CGPoint(x: size.width/2, y: size.height)
                case .toBottomLeft:
                    startPoint = CGPoint(x: size.width, y: 0.0)
                    endPoint = CGPoint(x: 0.0, y: size.height)
                case .toBottomRight:
                    startPoint = CGPoint(x: 0.0, y: 0.0)
                    endPoint = CGPoint(x: size.width, y: size.height)
                case .toTopLeft:
                    startPoint = CGPoint(x: size.width, y: size.height)
                    endPoint = CGPoint(x: 0.0, y: 0.0)
                case .toTopRight:
                    startPoint = CGPoint(x: 0.0, y: size.height)
                    endPoint = CGPoint(x: size.width, y: 0.0)
                }

                context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions())
            }

            guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
                return nil
            }

            self.init(cgImage: image)

            defer { UIGraphicsEndImageContext() }
        }

        convenience init?(color: UIColor, size: CGSize) {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            let rect = CGRect(origin: CGPoint.zero, size: size)
            UIRectFill(rect)

            guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
                return nil
            }

            self.init(cgImage: image)

            defer { UIGraphicsEndImageContext() }
        }

    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    func trim(trimRect :CGRect) -> UIImage {
        if CGRect(origin: CGPoint.zero, size: self.size).contains(trimRect) {
            if let imageRef = self.cgImage?.cropping(to: trimRect) {
                return UIImage(cgImage: imageRef)
            }
        }

        UIGraphicsBeginImageContextWithOptions(trimRect.size, true, self.scale)
        self.draw(in: CGRect(x: -trimRect.minX, y: -trimRect.minY, width: self.size.width, height: self.size.height))
        let trimmedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let image = trimmedImage else { return self }

        return image
    }

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    
    var squared: UIImage? {
        let originalWidth  = size.width
        let originalHeight = size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0
        
        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0
            
        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }
        
        let cropSquare = CGRect(x: x, y: y, width: edge, height: edge)
        guard let imageRef = cgImage?.cropping(to: cropSquare) else { return nil }
        
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }

    func resized(maxSize: CGFloat) -> UIImage? {
        let scale: CGFloat
        if size.width > size.height {
            scale = maxSize / size.width
        }
        else {
            scale = maxSize / size.height
        }
        
        let newWidth = size.width * scale
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }


}
