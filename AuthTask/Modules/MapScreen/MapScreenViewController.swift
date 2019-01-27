//
//  MapScreenViewController.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class MapScreenViewController: BaseViewController,UIGestureRecognizerDelegate {
    
    var model: MapScreenModel?
    var myView: MapScreenView? { return self.view as? MapScreenView }
    private var isnavigated = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view = MapScreenView(frame:  UIScreen.main.bounds)
        model = MapScreenModel()
        self.title = "Maps"
        let appdel =  UIApplication.shared.delegate as! AppDelegate
        appdel.startUpdatinglocation()
        myView?.viewMap?.showsUserLocation = true
        setupMaps()
    }
    func setupMaps(){
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(MapScreenViewController.handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.1
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        myView?.viewMap?.addGestureRecognizer(lpgr)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isnavigated {
            isnavigated = false
        }
    }
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: myView?.viewMap)
            let locationCoordinate = myView?.viewMap?.convert(touchLocation,toCoordinateFrom: myView?.viewMap)
            //print("Tapped at lat: \(locationCoordinate?.latitude) long: \(locationCoordinate?.longitude)")
            navigateToNext(lat: locationCoordinate?.latitude ?? 0.0, lng: locationCoordinate?.longitude ?? 0.0)
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
    func navigateToNext(lat:Double,lng:Double){
        if isnavigated == false{
            isnavigated = true
            let nextscreen = WeatherMapViewController()
            nextscreen.lat = lat
            nextscreen.lng = lng
            self.navigationController?.pushViewController(nextscreen, animated: true)
        }
    }
   
}
