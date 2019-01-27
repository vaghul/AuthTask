//
//  WeatherMapModel.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit
import CoreData

protocol WeatherMapModelDelegate: class {
    
    func recievedResponce(_ value: [String:AnyObject]?, method: String)
    func errorResponce(_ value: String, method: String)
    
}

class WeatherMapModel: BaseModel {

    weak var delegate: WeatherMapModelDelegate?
    var arrayweather:[AnyObject]!
    var arrayinfo:[AnyObject]!
    var city:String!,country:String!
    override func responceRecieved(_ response: [String : AnyObject],method:String) {
        if method == "weatherdetails"{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let ent = Entity(context: context)
            let CDweather = Weather(context: context)
            if response["weather"] != nil {
                if response["weather"] is [AnyObject] {
                    arrayweather = response["weather"] as? [AnyObject]
                    let obj = arrayweather[0] as! [String:AnyObject]
                    CDweather.main = obj["main"] as? String
                    CDweather.desc = obj["description"] as? String
                    CDweather.icon = obj["icon"] as? String
                }
            }

            ent.weather = CDweather
            ent.id = Int32(truncating: response["id"] as! NSNumber)
            let coord = response["coord"] as! [String:AnyObject]
            ent.lat = Double(truncating: coord["lat"] as! NSNumber)
            ent.lng = Double(truncating: coord["lon"] as! NSNumber)
            let main = response["main"] as! [String:AnyObject]
            let CDmain = Main(context: context)
            
            arrayinfo = [AnyObject]()
            if main["temp"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Temperature" as AnyObject
                obj["value"] = "\(main["temp"]!) Kelvin" as AnyObject
                CDmain.temp = "\(main["temp"]!) Kelvin"
                arrayinfo.append(obj as AnyObject)
            }
            
            if main["pressure"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure" as AnyObject
                obj["value"] = "\(main["pressure"]!) hPa" as AnyObject
                CDmain.pressure = "\(main["pressure"]!) hPa"
                arrayinfo.append(obj as AnyObject)
            }
            
            if main["humidity"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Humidity" as AnyObject
                obj["value"] = "\(main["humidity"]!) %" as AnyObject
                CDmain.humidity = "\(main["humidity"]!) %"
                arrayinfo.append(obj as AnyObject)
            }
            
            if main["temp_min"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Minimum temperature" as AnyObject
                obj["value"] = "\(main["temp_min"]!) Kelvin" as AnyObject
                CDmain.temp_min = "\(main["temp_min"]!) Kelvin"
                arrayinfo.append(obj as AnyObject)
            }
            if main["temp_max"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Maximum temperature" as AnyObject
                obj["value"] = "\(main["temp_max"]!) Kelvin" as AnyObject
                CDmain.temp_max = "\(main["temp_max"]!) Kelvin"
                arrayinfo.append(obj as AnyObject)
            }
            if main["sea_level"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure on the sea level" as AnyObject
                obj["value"] = "\(main["sea_level"]!) hPa" as AnyObject
                CDmain.sea_level = "\(main["sea_level"]!) hPa"
                arrayinfo.append(obj as AnyObject)
            }
            if main["grnd_level"] != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure on the ground level" as AnyObject
                obj["value"] = "\(main["grnd_level"]!) hPa" as AnyObject
                CDmain.grnd_level = "\(main["grnd_level"]!) hPa"
                arrayinfo.append(obj as AnyObject)
            }
            ent.main = CDmain
            let CDwind = Wind(context: context)
            if let wind = response["wind"] as! [String:AnyObject]? {
                if wind["speed"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = " Wind speed" as AnyObject
                    obj["value"] = "\(wind["speed"]!) meter/sec" as AnyObject
                    CDwind.speed = "\(wind["speed"]!) meter/sec"
                    arrayinfo.append(obj as AnyObject)
                }
                if wind["deg"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Wind direction" as AnyObject
                    obj["value"] = "\(wind["deg"]!) degrees" as AnyObject
                    CDwind.deg = "\(wind["deg"]!) degrees"
                    arrayinfo.append(obj as AnyObject)
                }
            }
            ent.wind = CDwind
            let CDcloud = Clouds(context: context)
            if let cloud = response["clouds"] as! [String:AnyObject]? {
                if cloud["all"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Cloudiness" as AnyObject
                    obj["value"] = "\(cloud["all"]!) %" as AnyObject
                    CDcloud.all = "\(cloud["all"]!) %"
                    arrayinfo.append(obj as AnyObject)
                }
            }
            ent.clouds = CDcloud
            let CDrain = Rain(context: context)
            if let rain = response["rain"] as! [String:AnyObject]? {
                if rain["1h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Rain volume for the last hour" as AnyObject
                    obj["value"] = "\(rain["1h"]!) mm" as AnyObject
                    CDrain.h1 = "\(rain["1h"]!) mm"
                    arrayinfo.append(obj as AnyObject)
                }
                if rain["3h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Rain volume for the last 3 hours" as AnyObject
                    obj["value"] = "\(rain["3h"]!) mm" as AnyObject
                    CDrain.h3 = "\(rain["3h"]!) mm"
                    arrayinfo.append(obj as AnyObject)
                }
            }
            ent.rain = CDrain
            let CDsnow = Snow(context: context)
            if let snow = response["snow"] as! [String:AnyObject]? {
                if snow["1h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Snow volume for the last hour" as AnyObject
                    obj["value"] = "\(snow["1h"]!) mm" as AnyObject
                    CDsnow.h1 = "\(snow["1h"]!) mm"
                    arrayinfo.append(obj as AnyObject)
                }
                if snow["3h"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Snow volume for the last 3 hours" as AnyObject
                    obj["value"] = "\(snow["3h"]!) mm" as AnyObject
                    CDsnow.h3 = "\(snow["3h"]!) mm"
                    arrayinfo.append(obj as AnyObject)
                }
            }
            ent.snow = CDsnow
            let CDsys = Sys(context: context)
            if let sys = response["sys"] as! [String:AnyObject]? {
                if sys["sunrise"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Sunrise time" as AnyObject
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm:ss"
                    let datestring = formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: sys["sunrise"] as! NSNumber)) as Date)
                    obj["value"] = datestring as AnyObject
                    CDsys.sunrise = datestring
                    arrayinfo.append(obj as AnyObject)
                }
                if sys["sunset"] != nil {
                    var obj = [String:AnyObject]()
                    obj["key"] = "Sunset time" as AnyObject
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm:ss"
                    let datestring = formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(truncating: sys["sunset"] as! NSNumber)) as Date)
                    obj["value"] = datestring as AnyObject
                    CDsys.sunset = datestring
                    arrayinfo.append(obj as AnyObject)
                }
                city = response["name"] as? String
                ent.city = city
                if sys["country"] != nil {
                    country = sys["country"] as? String
                    CDsys.country = country
                }
                ent.sys = CDsys
                appDelegate.saveContext()
            }
        }
        delegate?.recievedResponce(response, method: method)
    }
    func buildOfflineData(userdata:AnyObject){
        let obj = userdata as! [String:AnyObject]
        city = obj["city"] as? String
        let ent = obj["obj"] as! NSManagedObject
        arrayinfo = [AnyObject]()
        if let weather = ent.value(forKey: "weather") as! NSManagedObject? {
            arrayweather = [AnyObject]()
            var obj = [String:AnyObject]()
            obj["main"] = weather.value(forKey: "main") as AnyObject
            obj["description"] = weather.value(forKey: "desc") as AnyObject
            obj["icon"] = weather.value(forKey: "icon") as AnyObject
            arrayweather.append(obj as AnyObject)
        }
        if let main = ent.value(forKey: "main") as! NSManagedObject? {
            if main.value(forKey: "temp") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Temperature" as AnyObject
                obj["value"] = main.value(forKey: "temp") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main.value(forKey: "pressure") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure" as AnyObject
                obj["value"] = main.value(forKey: "pressure") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main.value(forKey: "humidity") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Humidity" as AnyObject
                obj["value"] = main.value(forKey: "humidity") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main.value(forKey: "temp_min") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Minimum temperature" as AnyObject
                obj["value"] = main.value(forKey: "temp_min") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main.value(forKey: "temp_max") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Maximum temperature" as AnyObject
                obj["value"] = main.value(forKey: "temp_max") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main.value(forKey: "sea_level") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure on the sea level" as AnyObject
                obj["value"] = main.value(forKey: "sea_level") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if main.value(forKey: "grnd_level") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Atmospheric pressure on the ground level" as AnyObject
                obj["value"] = main.value(forKey: "grnd_level") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
        }
        if let wind = ent.value(forKey: "wind") as! NSManagedObject? {
            
            if wind.value(forKey: "speed") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Wind speed" as AnyObject
                obj["value"] = wind.value(forKey: "speed") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if wind.value(forKey: "deg") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Wind direction" as AnyObject
                obj["value"] = wind.value(forKey: "deg") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
        }
        if let clouds = ent.value(forKey: "clouds") as! NSManagedObject? {
            if clouds.value(forKey: "all") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Cloudiness" as AnyObject
                obj["value"] = clouds.value(forKey: "all") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
        }
        if let rain = ent.value(forKey: "rain") as! NSManagedObject? {
            if rain.value(forKey: "h1") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Rain volume for the last hour" as AnyObject
                obj["value"] = rain.value(forKey: "h1") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if rain.value(forKey: "h3") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Rain volume for the last 3 hours" as AnyObject
                obj["value"] = rain.value(forKey: "h3") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
        }
        
        if let snow = ent.value(forKey: "snow") as! NSManagedObject? {
            if snow.value(forKey: "h1") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Snow volume for the last hour" as AnyObject
                obj["value"] = snow.value(forKey: "h1") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if snow.value(forKey: "h3") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Snow volume for the last 3 hours" as AnyObject
                obj["value"] = snow.value(forKey: "h3") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
        }
        
        if let sys = ent.value(forKey: "sys") as! NSManagedObject? {
            if sys.value(forKey: "sunrise") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Sunrise time" as AnyObject
                obj["value"] = sys.value(forKey: "sunrise") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if sys.value(forKey: "sunset") != nil {
                var obj = [String:AnyObject]()
                obj["key"] = "Sunset time" as AnyObject
                obj["value"] = sys.value(forKey: "sunset") as AnyObject
                arrayinfo.append(obj as AnyObject)
            }
            if sys.value(forKey: "country") != nil {
                country = sys.value(forKey: "country") as? String
            }
        }
        delegate?.recievedResponce(nil, method: "weatherdetails")
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
