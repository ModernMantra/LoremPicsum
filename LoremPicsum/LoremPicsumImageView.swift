//
//  LoremPicsumImageView.swift
//  LoremPicsum
//
//  Created by Kerim Njuhovic on 11/12/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

@IBDesignable
public class LoremPicsumImageView: UIImageView {
    
    private var blurView: UIVisualEffectView?
    
    @IBInspectable var imageTintColor: UIColor? {
        didSet {
            self.image = self.image?.tintImage(with: imageTintColor!)
        }
    }
    
    @IBInspectable var imageFillColor: UIColor? {
        didSet{
            self.image = self.image?.tintWith(fillColor: imageFillColor!)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var blur: Bool = false {
        didSet {
            if (blur) {
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = self.bounds
                self.blurView = blurEffectView
                
                // for supporting device rotation
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.addSubview(blurEffectView)
            }
            else {
                if let view = self.blurView {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    @IBInspectable var CImageFilterName: String = "" {
        didSet{
            do {
                let trimmedFilterName = CImageFilterName.trimmingCharacters(in: .whitespaces)
                let imageWithCIFilter = try self.image?.imageWithCIFilter(filterName: trimmedFilterName)
                self.image = imageWithCIFilter
            }
            catch {
                // The CIFilter with entered name does not exist
            }
        }
    }
    
    @IBInspectable var imageUrl: String = "" {
        didSet {
            if let imageFromUrl = self.image?.loadImage(urlString: imageUrl) {
                self.image = imageFromUrl
            }
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // MARK: - Initializers
    
    override public init(image: UIImage?) {
        super.init(image: image)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
