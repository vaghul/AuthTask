//
//  MapScreenViewController.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit
import MapKit

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
        myView?.viewMap?.delegate = self
        setupMaps()
        addpins()
        
    }
    func addpins(){
        model?.preparePin()
        for item in (model?.arraypin)! {
            let annotation = CustomAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: item["lat"] as! Double, longitude:item["lng"] as! Double)
            annotation.coordinate = centerCoordinate
            annotation.title = item["city"] as? String
            annotation.userdata = item
            myView?.viewMap?.addAnnotation(annotation)
        }
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
        if (model?.isinternetavail())! {
            if isnavigated == false{
                isnavigated = true
                let nextscreen = WeatherMapViewController()
                nextscreen.lat = lat
                nextscreen.lng = lng
                self.navigationController?.pushViewController(nextscreen, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Internet unavailable", message: "Please check your internet connection and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
   
}
