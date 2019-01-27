//
//  MapScreenView.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit
import MapKit

class MapScreenView: BaseView {

    var viewMap:MKMapView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.onCreate()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCreate(){
        self.backgroundColor = .white
        viewMap = MKMapView()
        viewMap?.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
        addSubview(viewMap!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewMap?.frame = CGRect(x: 0, y: getSafeTop(), width: self.getWidth(), height: self.getHeight() - getSafeTop() - getSafeBottom())
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
