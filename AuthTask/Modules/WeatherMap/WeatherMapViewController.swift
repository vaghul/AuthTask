//
//  WeatherMapViewController.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class WeatherMapViewController: BaseViewController {

    var model: WeatherMapModel?
    var myView: WeatherMapView? { return self.view as? WeatherMapView }
    var lat:Double = 0.0
    var lng:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view = WeatherMapView(frame:  UIScreen.main.bounds)
        model = WeatherMapModel()
        model?.delegate = self
        self.title = "Weather Details"
        myView?.showBlurLoader()
        model?.getWeatherDetails(lat: lat, lng: lng)

        // Do any additional setup after loading the view.
    }
    
}
