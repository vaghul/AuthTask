//
//  MapScreen+.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import MapKit
extension MapScreenViewController:MKMapViewDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        if annotation.isKind(of: MKUserLocation.self){
//            return nil
//        }
//        if annotation.isKind(of: MKPointAnnotation.self){
//            let pinview = mapView.dequeueReusableAnnotationView(withIdentifier: "custom", for: annotation)
//            print(pinview)
//            pinview.canShowCallout = true
//            pinview.calloutOffset = CGPoint(x: 0, y: 32)
//            pinview.annotation = annotation
//            let btn = UIButton(type: .detailDisclosure)
//            pinview.rightCalloutAccessoryView = btn
//            return pinview
//        }
//        return nil;
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        let annotation = view.annotation
        let custom = annotation as! CustomAnnotation
        let nextscreen = WeatherMapViewController()
        nextscreen.coreobj = custom.userdata
        self.navigationController?.pushViewController(nextscreen, animated: true)
    }
    
}
