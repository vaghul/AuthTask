//
//  BaseView.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class BaseView: UIView {

    
    func getSafeBottom() -> CGFloat {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets.bottom
        } else {
            return 0
            // Fallback on earlier versions
        }
    }
    
    func getSafeTop() -> CGFloat {
        //         guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets.top
        } else {
            return UIApplication.shared.statusBarFrame.size.height
            // Fallback on earlier versions
        }
    }

}
