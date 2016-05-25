//
//  EpisodesClass.swift
//  POCApp
//
//  Created by Harry_w on 5/6/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class EpisodesClass: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var ShowImage: UIImageView!
    
    @IBOutlet weak var TitleLbl: UILabel!
    
    
    var img1 : UIImage = UIImage()
    var title1 : NSString = NSString()
    var seasonnum : NSString = NSString()
    var date : NSString = NSString()
    var Linkdetails : NSString = NSString()


    @IBOutlet weak var Collectionview: UICollectionView!

    var titleseas : NSString = NSString()
    var IDE : NSString = NSString()

    var idstring1 : NSString = NSString()
    var seasonnumber : NSString = NSString()
    var LinkName : NSMutableArray = NSMutableArray()
    var download : NSMutableArray = NSMutableArray()

    var Linkarray : NSMutableArray = NSMutableArray()

   // @IBOutlet weak var LinkdetailsLbl: UILabel!
    
    @IBOutlet weak var TitleSeason: UILabel!
    
    @IBOutlet weak var Description: UITextView!
    
    @IBOutlet weak var ShowDate: UILabel!
   
    var download1 : NSString = NSString()
    var download11 : NSString = NSString()

    @IBOutlet weak var AvailableBtn1: UIButton!
    
    
    @IBOutlet weak var AvailableBtn3: UIButton!
    
    @IBOutlet weak var AvailableBtn2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Collectionview.dataSource = self
        Collectionview.delegate = self
        //https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/show/2098/episodes/1/0/25/subscription,purchase/ios/true
        //https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/show/300/episodes/all/0/25/tv_everywhere,subscription,purchase/ios/true
        
        let UrlString11 : NSString = NSString(format: "\(baseURL)episode/%@",IDE)
        let url11 = NSURL(string: UrlString11 as String)
        let data11 = NSData(contentsOfURL: url11!)
        
        do {
            
            let jsonData112 = try NSJSONSerialization.JSONObjectWithData(data11!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
                
            let overv1 = jsonData112.objectForKey("overview")
            Description.text = overv1 as! String
            let a1 = jsonData112.objectForKey("subscription_ios_sources") as! NSArray
            for var d1 in a1
            {
                let Link1 = d1.objectForKey("display_name")
                Linkarray.addObject(Link1!)
                let Link2 = d1.objectForKey("link")
                LinkName.addObject(Link2!)
                download1 = d1.objectForKey("app_download_link") as! NSString
                download.addObject(download1)
                
            }
                let a11 = jsonData112.objectForKey("purchase_ios_sources") as! NSArray
                for var d11 in a11
                {
                    let Link11 = d11.objectForKey("display_name")
                    Linkarray.addObject(Link11!)
                    let Link22 = d11.objectForKey("link")
                    LinkName.addObject(Link22!)
                    download1 = d11.objectForKey("app_download_link") as! NSString
                    download.addObject(download1)
                    
                    
                }//tv_everywhere_ios_sources
             let a111 = jsonData112.objectForKey("tv_everywhere_ios_sources") as! NSArray
             for var d111 in a111
             {
                let Link111 = d111.objectForKey("display_name")
                Linkarray.addObject(Link111!)
                let Link221 = d111.objectForKey("link")
                LinkName.addObject(Link221!)
                download1 = d111.objectForKey("app_download_link") as! NSString
                download.addObject(download1)
                
                
             }//free_ios_sources
            let a112 = jsonData112.objectForKey("free_ios_sources") as! NSArray
            for var d112 in a112
            {
                let Link111 = d112.objectForKey("display_name")
                
                Linkarray.addObject(Link111!)
                let Link221 = d112.objectForKey("link")
                LinkName.addObject(Link221!)
                download1 = d112.objectForKey("app_download_link") as! NSString
                download.addObject(download1)
                
            }
            
          //  var yourArray: [AnyObject] = ["1", "2", "3", "1"]
            let result: NSMutableArray = NSMutableArray()
            LinkName.enumerateObjectsUsingBlock({ object, index, stop in
                if !result.containsObject(object) {
                    result.addObject(object)
                }
            })
            
            NSLog("%@", result)
            print(LinkName)
           }
        
        catch
        {
            
        }
        
        ShowImage.image = img1
        TitleLbl.text = title1 as String
        titleseas = titleseas.stringByAppendingString(", \(seasonnum)")
        TitleSeason.text = titleseas as String
        ShowDate.text = date as String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - CollectionView

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return LinkName.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as! EpisodeCell
        
        cell.LinkdetailsLbl.hidden = true
        cell.ChannelLbl.text = Linkarray.objectAtIndex(indexPath.row) as? String
        cell.LinkdetailsLbl.text = LinkName.objectAtIndex(indexPath.row) as? String
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! EpisodeCell
                print(LinkName.objectAtIndex(indexPath.item))
        
        var String1 = LinkName.objectAtIndex(indexPath.item) as! NSString
        
        
        String1 = String1.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        print("%d\(String1.length)")
        
        let t_st = ":"
        
        let range = String1.rangeOfString(t_st, options: .CaseInsensitiveSearch) as NSRange
        
        var subString: String = String1.substringWithRange(NSMakeRange(0, String1.rangeOfString(":").location))

        subString = subString.stringByAppendingString("://")
        
        if range.length == t_st.characters.count
        {
            NSLog("done")
        }
        else
        {
            NSLog("not done")
        }
        print(String1)
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string:subString)!)
        {
            UIApplication.sharedApplication().openURL(NSURL(string: String1 as String)!)
        }
        
        else
        {
            print(cell.LinkdetailsLbl.text)
            print(LinkName.objectAtIndex(indexPath.item))
            let alert = UIAlertController(title: "Alert!", message: "You don't have this Application in your TV Please Install and Try again", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                UIApplication.sharedApplication().openURL(NSURL(string: self.download[indexPath.item] as! String)!)
            }))
            alert.addAction(UIAlertAction(title: "No, Thanks", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                
            }))
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.presentViewController(alert, animated: true, completion: { _ in })
            })
         }
        
    }
    /*
        // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
