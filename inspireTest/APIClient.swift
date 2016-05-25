//
//  APIClient.swift
//  inspireTest
//
//  Created by Harry on 11/16/15.
//  Copyright © 2015 Harry. All rights reserved.
//

import UIKit
//import AFNetwork
class APIClient: NSObject, NSURLConnectionDataDelegate{
    
    let manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    let JSONResponse : AFJSONResponseSerializer = AFJSONResponseSerializer()
    let AFHTTPResponse : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
    var responseData : NSMutableData!
    
    class var sharedInstance : APIClient {
        struct Static {
            static let instance : APIClient = APIClient()
        }
        
        return Static.instance
    }
    
    /*
    
    func post(url: NSString!, parameters: NSDictionary!, completionHandler:(NSDictionary!, NSError!)->(), isJson: Bool = true) ->() {
    var version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
    
    if (version > 7) {
    
    manager.responseSerializer = JSONResponse
    manager.requestSerializer = isJson ? AFJSONRequestSerializer() : AFHTTPRequestSerializer()
    
    manager.POST(baseURL.stringByAppendingString(url),
    parameters: parameters,
    success: { (operation: AFHTTPRequestOperation!, responseData: AnyObject!) in
    var responseDict = responseData as NSDictionary
    println(responseDict)
    completionHandler(responseDict, nil)
    },
    failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
    completionHandler(nil, error)
    }
    );
    }
    }
    
    
    
    func get(url: NSString!, parameters: NSDictionary!, completionHandler:(NSDictionary!, NSError!)->()) ->() {
    println("Requesting \(baseURL.stringByAppendingString(url))")
    println("Parameters: \(parameters)")
    
    var version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
    println("Device: \(version)")
    if (version > 7) {
    manager.responseSerializer = JSONResponse
    
    manager.GET(baseURL.stringByAppendingString(url),
    parameters: parameters,
    success: { (operation: AFHTTPRequestOperation!, responseData: AnyObject!) in
    var responseDict : NSDictionary!
    if(responseData.count > 0){
    responseDict = responseData as NSDictionary
    }
    completionHandler(responseDict,nil)
    },
    failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
    completionHandler(nil, error)
    }
    );
    }
    
    }
    */
    
//    func doLogin(url: NSString!, parameters: NSDictionary?, completionHandler:(NSDictionary!, NSError!)->()) ->() {
//        let version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
//        if (version > 7) {
//            manager.responseSerializer = JSONResponse
//            
//            let urlstr = baseURL.stringByAppendingString(url as String)
//            
//            manager.GET(urlstr,
//                parameters: parameters,
//                success: { (operation: AFHTTPRequestOperation!, responseData: AnyObject!) in
//                    let responseDict = responseData as! NSDictionary
//                    let cookie = operation.response.allHeaderFields["Set-Cookie"] as! NSString
//                    print(cookie)
//                    //    println("URL:\(baseURL.stringByAppendingString(url))")
//                    Helper.addToNSUserDefaults(cookie, key: kJSESSIONID)
//                    
//                    completionHandler(responseDict, nil)
//                },
//                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//                    completionHandler(nil, error)
//                }
//            );
//        }
//        else{
//            print("Not supported for this iOS version")
//        }
//    }
//    
//    func doLogout( parameters: NSDictionary?, completionHandler:(NSDictionary!, NSError!)->()) ->() {
//        let version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
//        if (version > 7) {
//            
//            manager.responseSerializer = JSONResponse
//            manager.GET(baseURL.stringByAppendingString(LogoutURL),
//                parameters: parameters,
//                success: { (operation: AFHTTPRequestOperation!, responseData: AnyObject!) in
//                    let responseDict = responseData as! NSDictionary
//                    completionHandler(responseDict, nil)
//                },
//                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//                    completionHandler(nil, error)
//                }
//            );
//        }
//        else{
//            print("Not supported for this iOS version")
//        }
//    }
//    
//    //
//    //    func getQuestionList(parameters: NSDictionary?, completionHandler:(NSDictionary!, NSError!)->()) ->() {
//    //        var version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
//    //        if (version > 7) {
//    //             //   manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
//    //    let JSONResponse : AFJSONResponseSerializer = AFJSONResponseSerializer()
//    //   manager.responseSerializer = AFHTTPResponse
//    //
//    //            var request = NSMutableURLRequest(URL: NSURL(string: "http://app.gamerparentsinc.com/general/client-mobileNextQuestion")!)
//    //            let cookieValue = Helper.getFromNSUserDefaults(kJSESSIONID) as NSString
//    //
//    //        request.setValue(cookieValue, forHTTPHeaderField: "Cookie")
//    //
//    //            manager.HTTPRequestOperationWithRequest(request, success: { (operation, response) -> Void in
//    //
//    //                println(response)
//    //                println("Success")
//    //
//    //            }, failure: { (operation, error) -> Void in
//    //
//    //                println(error)
//    //                println("failure")
//    //
//    //
//    //            })
//    //
//    //    }
//    //    }
//    
//    
//    
//    
//    func getQuestionList(parameters: NSDictionary?, completionHandler:(NSDictionary!, NSError!)->()) ->() {
//        let version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
//        if (version > 7) {
//            manager.responseSerializer = JSONResponse
//            
//            let cookieValue = Helper.getFromNSUserDefaults(kJSESSIONID) as! NSString
//            //   println(cookieValue)
//            manager.requestSerializer.setValue(cookieValue as String, forHTTPHeaderField: "Cookie")
//            
//            manager.GET(baseURL.stringByAppendingString(QuestionURL),
//                parameters: parameters,
//                success: { (operation: AFHTTPRequestOperation!, responseData: AnyObject!) in
//                    //    println(responseData)
//                    //    println(operation)
//                    
//                    if responseData == nil {
//                        print("responseData is null")
//                        return
//                    }
//                    
//                    //                   var jsonError:NSError?
//                    //
//                    //                    if let json = NSJSONSerialization.JSONObjectWithData(responseData as NSData, options: nil, error: &jsonError) as? NSDictionary{
//                    //                        println(json)
//                    //                    }
//                    //                    else{
//                    //                        if let unwrappedError = jsonError {
//                    //                            println("json error: \(unwrappedError)")
//                    //                        }
//                    //                    }
//                    //
//                    
//                    let responseDict = responseData as! NSDictionary
//                    
//                    completionHandler(responseDict, nil)
//                },
//                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//                    print(error.description)
//                    completionHandler(nil, error)
//                }
//            );
//        }
//        else{
//            print("Not supported for this iOS version")
//        }
//    }
//    
//    func postAnswer(parameters: NSDictionary?, completionHandler:(NSDictionary!, NSError!)->()) ->() {
//        let version = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
//        if (version > 7) {
//            manager.responseSerializer = JSONResponse
//            let cookieValue = Helper.getFromNSUserDefaults(kJSESSIONID)as! NSString
//            manager.requestSerializer.setValue(cookieValue as String, forHTTPHeaderField: "Cookie")
//            
//            manager.GET(baseURL.stringByAppendingString(PostAnswerURL),
//                parameters: parameters,
//                success: { (operation: AFHTTPRequestOperation!, responseData: AnyObject!) in
//                    //    println(responseData)
//                    
//                    if responseData == nil {
//                        print("responseData is null")
//                        return
//                    }
//                    
//                    let responseDict = responseData as! NSDictionary
//                    
//                    completionHandler(responseDict, nil)
//                },
//                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//                    print(error.description)
//                    completionHandler(nil, error)
//                }
//            );
//        }
//        else{
//            print("Not supported for this iOS version")
//        }
//    }
}
