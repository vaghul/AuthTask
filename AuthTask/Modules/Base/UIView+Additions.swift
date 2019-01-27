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
}
