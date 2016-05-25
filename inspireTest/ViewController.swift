//
//  ViewController.swift
//  inspireTest
//
//  Created by Harry on 11/16/15.
//  Copyright © 2015 Harry. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var datearray : NSMutableArray = NSMutableArray()
    var Imagearray : NSMutableArray = NSMutableArray()
    var Tvnamearray : NSMutableArray = NSMutableArray()
    var idarray : NSMutableArray = NSMutableArray()
    var Titlearray : NSMutableArray = NSMutableArray()

    
    @IBOutlet var passwordTxtFld: UITextField!
    var Titlestring : NSString = NSString()
    
    
    @IBOutlet var welcomeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBarHidden = true

        passwordTxtFld.delegate = self
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
    }
    
    
    @IBAction func Login_btn(sender: AnyObject)
    {
        
               
        KVNProgress.showWithStatus("Loading...")
        KVNProgress.show()
        let Search : SearchResultClass = self.storyboard?.instantiateViewControllerWithIdentifier("SRC") as! SearchResultClass
        var UrlString : NSString = NSString(format: "\(baseURL)search/title/%@/fuzzy", self.passwordTxtFld.text!)
        UrlString = UrlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
       
        
        let manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.GET(UrlString as String, parameters: nil, success: { (oparation, responceobject) in
            print(responceobject)
            Search.SearchString = self.passwordTxtFld.text!
             KVNProgress.show()
            let Titlestring1 = responceobject.objectForKey("results") as! NSArray
            if Titlestring1.count != 0
            {
           
            for var dict in Titlestring1
                {
                    let string = dict.objectForKey("title")
                    if string!.caseInsensitiveCompare(self.passwordTxtFld.text!) == .OrderedSame
                    {
                    Search.SearchString = string as! String
                    }
                        
                }
                
            }
            self.navigationController?.pushViewController(Search, animated: true)
        })
          { (oparation, responceobject) in
            
                print(responceobject)
                
        }
        
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        
        KVNProgress.dismiss()
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        //override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //  usernameTxtFld.resignFirstResponder()
        //  passwordTxtFld.resignFirstResponder()
        self.view.endEditing(true)
        
    }
    
    
    
    // MARK: UITextField Delegate
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
         if (textField == passwordTxtFld){
            self.Login_btn(self)
            passwordTxtFld.resignFirstResponder()
            
        }
        else{
            textField.resignFirstResponder()
        }
        return true
        
    }

    
}

