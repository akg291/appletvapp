//
//  MoviedetailsClass.swift
//  POCApp
//
//  Created by Harry_w on 5/12/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class MoviedetailsClass: UIViewController {

    @IBOutlet weak var Overview: UITextView!
    @IBOutlet weak var ActressLbl: UILabel!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieImage: UIImageView!
    var idstr : NSString = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
