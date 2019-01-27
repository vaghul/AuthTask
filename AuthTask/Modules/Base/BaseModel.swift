//
//  BaseModel.swift
//  AuthTask
//
//  Created by Vaghula Krishnan on 27/01/19.
//  Copyright © 2019 Vaghula Krishnan. All rights reserved.
//

import UIKit
import Alamofire

class BaseModel: NSObject {

    func sendGetRequest(_ urlstring:String,body:[String:AnyObject],method:String)     {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let param = body.stringFromHttpParameters()
        
        print("\(urlstring)?\(param)")
        Alamofire.request("\(urlstring)?\(param)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if response.result.isSuccess {
                if let json = response.result.value {
                    let jsondata = json as! [String:AnyObject]
                    if jsondata["cod"] as! NSNumber == 200 {
                        self.responceRecieved(jsondata,method: method)
                    }else if jsondata["message"] != nil {
                        self.errorRecieved(jsondata["message"] as! String,method: method)
                    }else{
                        self.errorRecieved("Unknown Error",method: method)
                    }
                }else{
                    self.errorRecieved("Unknown Error - 1",method: method)
                }
            }else{
                self.errorRecieved("Unknown Error - 2",method: method)
            }
        }
    }
    func responceRecieved(_ response :[String:AnyObject],method:String)
    {
        
    }
    func errorRecieved(_ response :String,method:String)
    {

    }
    func isinternetavail() -> Bool{
       return NetworkReachabilityManager()!.isReachable
    }
}
extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            }else{
                return "\(percentEscapedKey)=\(value)"
            }
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
    
}
