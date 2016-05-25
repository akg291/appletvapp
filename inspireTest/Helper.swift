//
//  Helper.swift
//  inspireTest
//
//  Created by Harry on 11/16/15.
//  Copyright © 2015 Harry. All rights reserved.
//
import Foundation
import UIKit

class Helper: NSObject {

    class func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(email)
        return result
        
    }
    
    
    class func addToNSUserDefaults(object:AnyObject, key:NSString) {
        
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(object, forKey: key  as String)
        defaults.synchronize()
        
    }
    class  func removeFromNSUserDefaults(forKey:NSString){
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(forKey as String)
        defaults.synchronize()
        
    }
    class func getFromNSUserDefaults(forkey:NSString) -> AnyObject{
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let robject: AnyObject? =  defaults.objectForKey(forkey as String)
        
        return robject!
    }
    class func scrollViewUp(upvalue:CGFloat, duration:Double, view:UIView) {
        UIView.animateWithDuration(duration, delay: 0.0, options: [], animations: { () -> Void in
            var rect:CGRect = view.frame
            rect.origin.y -= upvalue
            view.frame = rect
            
            }, completion: nil)
    }
    // UIView.animateWithDuration(duration, delay: 0.0, options: nil , animations: {
    //  var rect:CGRect = view.frame
    //  rect.origin.y -= upvalue
    // view.frame = rect
    //}, completion: nil)
    //}
    
    class func scrollViewDown(downvalue:CGFloat, duration:Double, view:UIView) {
        
        UIView.animateWithDuration(duration, delay: 0.0, options: [] , animations: {
            var rect:CGRect = view.frame
            rect.origin.y += downvalue
            view.frame = rect
            }, completion: nil)
    }
    
    
    // http://stackoverflow.com/questions/2053568/managing-http-cookies-on-iphone
}