//
//  UIImageView+Animations.swift
//  LoremPicsum
//
//  Created by Kerim Njuhovic on 11/12/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

public extension UIImageView {
    
    /// Fade the image in.
    ///
    /// - Parameters:
    ///   - duration: duration of the animation, in seconds
    ///   - delay: delay before the animation starts, in seconds
    ///   - completion: block executed when the animation ends
    ///   - image: new image that will be set instead of previous one
    public func fadeIn(duration: TimeInterval = 0.25,
                       delay: TimeInterval = 0,
                       completion: ((Bool) -> Void)? = nil,
                       image: UIImage) {
        UIView.animate(
            withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
                self.image = image
        }, completion: completion)
    }
    
    
    /// Using Cross Disolve animation firstly, after completing uses Ease Out using spring with dumping effect.
    ///
    /// - Parameters:
    ///   - expandTransformScale: x and y transfor, scale factor
    ///   - springWithDumpingDuration: duration in seconds
    ///   - bounceAnimationDuration: duration
    ///   - newImage: new image to be set
    ///   - completion: block which will be executed upon completing the whole animation
    public func bounce(expandTransformScale: CGFloat = 1.15,
                       springWithDumpingDuration: CGFloat = 0.4,
                       bounceAnimationDuration: TimeInterval = 0.4,
                       newImage: UIImage,
                       completion: ((Bool) -> Void)? = nil) {
        let expandTransform: CGAffineTransform = CGAffineTransform(scaleX: expandTransformScale, y: expandTransformScale)
        UIView.transition(with: self,
                          duration: 0.1,
                          options: UIViewAnimationOptions.transitionCrossDissolve,
                          animations: {
                            self.image = newImage
                            self.transform = expandTransform
        }, completion: {(finished: Bool) in
            UIView.animate(withDuration: bounceAnimationDuration,
                           delay: 0.0,
                           usingSpringWithDamping: springWithDumpingDuration,
                           initialSpringVelocity: 0.2,
                           options: .curveEaseOut,
                           animations: {
                            self.transform = expandTransform.inverted()
            }, completion: nil)
        })
    }
    
}
