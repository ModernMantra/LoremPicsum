//
//  UIImage+Extension.swift
//  LoremPicsum
//
//  Created by Kerim Njuhovic on 11/12/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

public extension UIImage {
    
    private enum LoremPicsumError: Error {
        case invalidCIFilterName
    }
    
    
    /// Collection of some pickedm CIFilter Photo effect names
    ///
    /// - CIPhotoEffectChrome: Set of effects that imitate vintage photography film with exaggerated color.
    /// - CIPhotoEffectFade: Set of effects that imitate vintage photography film with diminished color
    /// - CIPhotoEffectInstant: Set of effects that imitate vintage photography film with distorted colors.
    /// - CIPhotoEffectNoir: Set of effects that imitate black-and-white photography film with exaggerated contrast.
    /// - CIPhotoEffectProcess: Set of effects that imitate vintage photography film with emphasized cool colors.
    /// - CIPhotoEffectTonal: Set of effects that imitate black-and-white photography film without significantly altering contrast.
    /// - CIPhotoEffectTransfer: Set of effects that imitate vintage photography film with emphasized warm colors.
    /// - CISepiaTone: Maps the colors of an image to various shades of brown.
    public enum CIFilterNames: String {
        case CIPhotoEffectChrome
        case CIPhotoEffectFade
        case CIPhotoEffectInstant
        case CIPhotoEffectNoir
        case CIPhotoEffectProcess
        case CIPhotoEffectTonal
        case CIPhotoEffectTransfer
        case CISepiaTone
    }
    
    /// Tint, Colorize image with given tint color
    /// This is similar to Photoshop's "Color" layer blend mode
    /// This is perfect for non-greyscale source images, and images that
    /// have both highlights and shadows that should be preserved<br><br>
    /// white will stay white and black will stay black as the lightness of
    /// the image is preserved
    ///
    /// - Parameter TintColor: Tint color
    /// - Returns:  Tinted image
    public func tintImage(with fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)
            
            // draw original image
            context.setBlendMode(.normal)
            context.draw(cgImage!, in: rect)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            fillColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(context.makeImage()!, in: rect)
        }
    }
    
    /// Tint pictogram with color
    /// Method work on single colors without fading, mainly for svg images
    ///
    /// - Parameter fillColor: TintColor: Tint color
    /// - Returns:             Tinted image
    public func tintWith(fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(cgImage!, in: rect)
        }
    }
    
    /// Modified Image Context, apply modification on image
    ///
    /// - Parameter draw: (CGContext, CGRect) -> ())
    /// - Returns:        UIImage
    fileprivate func modifiedImage(_ draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    /// Applies CIFilter (in case the filter with given name exists), otherwise throws an error.
    ///
    /// - Parameters:
    ///   - filterName: CIFilterName to apply
    ///   - filterParameters: dictionary with key as string and value as Any object
    ///     (Some filter such as CIFalseColor needs input paramters inputColor0 and
    ///     inputColor1 to have more accurate filter result)
    /// - Returns: image (optional) with applied filter
    /// - Throws: Error in case the CIFilter could not be created with given name
    public func imageWithCIFilter(filterName: String, filterParameters: [String: Any] = [:]) throws -> UIImage? {
        if let openGLContext = EAGLContext(api: .openGLES2) {
            let context = CIContext(eaglContext: openGLContext)
            
            if let currentFilter = CIFilter(name: filterName) {
                let beginImage = CIImage(image: self)
                currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
                for (key, value) in filterParameters {
                    currentFilter.setValue(value, forKey: key)
                }
                
                if let output = currentFilter.outputImage {
                    if let cgimg = context.createCGImage(output, from: output.extent) {
                        let processedImage = UIImage(cgImage: cgimg)
                        return processedImage
                    }
                }
            }
            else {
                throw LoremPicsumError.invalidCIFilterName
            }
        }
        return nil
    }
    
    public func loadImage(urlString: String) -> UIImage? {
        var image: UIImage?
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if (error == nil) {
                    if let imageData = data as NSData? {
                        image = UIImage(data: imageData as Data)
                    }
                }
            })
        }
        return image
    }
    
}
