//
//  MapScreenModel.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

class MapScreenModel: BaseModel {

    var arraypin = [AnyObject]()
    
    func preparePin(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let val = appDelegate.fetchRecordsForEntity("Entity", inManagedObjectContext: context)
        for item in val {
            var obj = [String:Any]()
            obj["id"] = item.value(forKey: "id")
            obj["city"] = item.value(forKey: "city")
            obj["lat"] = item.value(forKey: "lat")
            obj["lng"] = item.value(forKey: "lng")
            obj["obj"] = item
            arraypin.append(obj as AnyObject)
        }
    }
   
}
