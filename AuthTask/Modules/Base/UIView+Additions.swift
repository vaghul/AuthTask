//
//  UIView+Additions.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

extension UIView {

    func calculateOffSetY() -> CGFloat{
        return self.getHeight() + self.getY()
    }
    func calculateOffSetX() -> CGFloat{
        return self.getWidth() + self.getX()
    }
    func getWidth() -> CGFloat {
        return self.frame.size.width
    }
    func getHeight() -> CGFloat {
        return self.frame.size.height
    }
    func getX() -> CGFloat {
        return self.frame.origin.x
    }
    func getY() -> CGFloat {
        return self.frame.origin.y
    }
    func showBlurLoader(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.addSubview(blurEffectView)
    }
    
    func removeBluerLoader(){
        self.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
}
