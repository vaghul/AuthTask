//
//  WeatherMapModel.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit

protocol WeatherMapModelDelegate: class {
    
    func recievedResponce(_ value: [String:AnyObject], method: String)
    func errorResponce(_ value: String, method: String)
    
}

class WeatherMapModel: BaseModel {

    weak var delegate: WeatherMapModelDelegate?
    var arrayweather:[AnyObject]!
    var arrayinfo:[AnyObject]!
    var city:String!,country:String!
    override func responceRecieved(_ response: [String : AnyObject],method:String) {
        if method == "weatherdetails"{
            if response["weather"] != nil {
                if response["weather"] is [AnyObject] {
                    arrayweather = response["weather"] as? [AnyObject]
                }
            }
            let main = response["main"] as! [String:AnyObject]
            arrayinfo = [AnyObject]()
            if main["temp"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Temperature" as AnyObject
                obj["value"] = "\(main["temp"]!) Kelvin" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            
            if main["pressure"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure" as AnyObject
                obj["value"] = "\(main["pressure"]!) hPa" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            
            if main["humidity"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Humidity" as AnyObject
                obj["value"] = "\(main["humidity"]!) %" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            
            if main["temp_min"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Minimum temperature" as AnyObject
                obj["value"] = "\(main["temp_min"]!) Kelvin" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main["temp_max"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Maximum temperature" as AnyObject
                obj["value"] = "\(main["temp_max"]!) Kelvin" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main["sea_level"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure on the sea level" as AnyObject
                obj["value"] = "\(main["sea_level"]!) hPa" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main["grnd_level"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure on the ground level" as AnyObject
                obj["value"] = "\(main["grnd_level"]!) hPa" as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if let wind = response["wind"] as! [String:AnyObject]? {
                if wind["speed"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = " Wind speed" as AnyObject
                    obj["value"] = "\(wind["speed"]!) meter/sec" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
                if wind["deg"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Wind direction" as AnyObject
                    obj["value"] = "\(wind["deg"]!) degrees" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
            }
            if let cloud = response["clouds"] as! [String:AnyObject]? {
                if cloud["all"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Cloudiness" as AnyObject
                    obj["value"] = "\(cloud["all"]!) %" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
            }
            if let rain = response["rain"] as! [String:AnyObject]? {
                if rain["1h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Rain volume for the last hour" as AnyObject
                    obj["value"] = "\(rain["1h"]!) mm" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
                if rain["3h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Rain volume for the last 3 hours" as AnyObject
                    obj["value"] = "\(rain["3h"]!) mm" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
            }
            if let snow = response["snow"] as! [String:AnyObject]? {
                if snow["1h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Snow volume for the last hour" as AnyObject
                    obj["value"] = "\(snow["1h"]!) mm" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
                if snow["3h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Snow volume for the last 3 hours" as AnyObject
                    obj["value"] = "\(snow["3h"]!) mm" as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
            }
            if let sys = response["sys"] as! [String:AnyObject]? {
                if sys["sunrise"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Sunrise time" as AnyObject
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm:ss"
                    let datestring = formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: sys["sunrise"] as! NSNumber)) as Date)
                    obj["value"] = datestring as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
                if sys["sunset"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Sunset time" as AnyObject
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm:ss"
                    let datestring = formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: sys["sunset"] as! NSNumber)) as Date)
                    obj["value"] = datestring as AnyObject
                    arrayinfo.append(obj as AnyObject)
                }
                city = response["name"] as? String
                if sys["country"] != nil {
                    country = sys["country"] as? String
                }
            }
        }
        delegate?.recievedResponce(response, method: method)
    }
    override func errorRecieved(_ response: String,method:String) {
        delegate?.errorResponce(response, method: method)
    }
    func getWeatherDetails(lat:Double,lng:Double){
        var param = [String:AnyObject]()
        param["lat"] = lat as AnyObject
        param["lon"] = lng as AnyObject
        param["appid"] = Macros.shared.appid as AnyObject
        sendGetRequest(Macros.shared.WeatherApi, body: param, method: "weatherdetails")
    }
}
