//
//  DetailviewClass.swift
//  POCApp
//
//  Created by Harry_w on 5/5/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class DetailviewClass: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
var Idstring : NSString = NSString()
     var drama : NSString = NSString()
    var act : NSString = NSString()

    var compare : NSString = NSString()
    var seasons : NSArray = NSArray()
    var array1 : NSString = NSString()
    var array3 : NSString = NSString()
    var im : UIImage = UIImage()
    var SeasonNumber : NSMutableArray = NSMutableArray()
    var thumbnail : NSMutableArray = NSMutableArray()
    var episodenumber : NSMutableArray = NSMutableArray()
    var episodeTitle : NSMutableArray = NSMutableArray()
    var first_aired : NSMutableArray = NSMutableArray()
    var episodeId : NSMutableArray = NSMutableArray()
 let result: NSMutableArray = NSMutableArray()
    var date : NSString = NSString()
    var number : NSNumber = NSNumber()
    @IBOutlet weak var Collectionview1: UICollectionView!

    @IBOutlet weak var Episodes: UILabel!
    @IBOutlet weak var SeasonsTableView: UITableView!
    @IBOutlet weak var SeasonsTextField: UITextField!
    
    @IBOutlet weak var SeasonsButton: UIButton!
    
    @IBOutlet weak var ImageforTVMV: UIImageView!
    
    @IBOutlet weak var TitleLbl: UILabel!
    
    @IBOutlet weak var NetworkLbl: UILabel!
    
    @IBOutlet weak var TypeLbl: UILabel!
    var availableon : NSMutableArray = NSMutableArray()
    var linkname : NSMutableArray = NSMutableArray()

    var downloadl : NSMutableArray = NSMutableArray()

    
    @IBOutlet weak var Description: UITextView!
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    override func viewDidLoad()
    {
        KVNProgress.show()
        Collectionview1.delegate = self
        Collectionview1.dataSource = self
        super.viewDidLoad()
        SeasonsTableView.hidden = true
        
        if (compare .isEqualToString("compare"))
        {
           
            Episodes.text = "Episodes"
            SeasonsTableView.delegate = self
            SeasonsTableView.dataSource = self
       
           
        //https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/show/300/episodes/all/0/25/tv_everywhere,subscription,purchase/ios/true
           let UrlString1 : NSString = NSString(format: "\(baseURL)show/%@",Idstring)
           let url1 = NSURL(string: UrlString1 as String)
           let data1 = NSData(contentsOfURL: url1!)
        
           do
            {
            
            let jsonData1 = try NSJSONSerialization.JSONObjectWithData(data1!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                         print(jsonData1)
            array3 = jsonData1.objectForKey("title") as! String
            array1 = jsonData1.objectForKey("title") as! String
            let array2 = jsonData1.objectForKey("rating") as! String
            array1 = array1.stringByAppendingFormat(",%@", array2)
            TitleLbl.text = array1 as String
            let network = jsonData1.objectForKey("network")//artwork_208x117
            let imgstring: String = (jsonData1["artwork_208x117"] as! String)
            self.ImageforTVMV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imgstring)!)!)
            NetworkLbl.text = network as? String
            let geners = jsonData1.objectForKey("genres") as! NSArray
            
            for var d in geners
            {
                 drama = d.objectForKey("title") as! NSString
            }
            let UrlString11 : NSString = NSString(format: "\(baseURL)show/%@/seasons",Idstring)
            let url11 = NSURL(string: UrlString11 as String)
            let data11 = NSData(contentsOfURL: url11!)
            
            do
            {
              let jsonData11 = try NSJSONSerialization.JSONObjectWithData(data11!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
              seasons = jsonData11.objectForKey("results") as! NSArray
              for var d1 in seasons
               {
                let num = d1.objectForKey("season_number") as! NSNumber
                SeasonNumber.addObject(num)
                
                var date2 = nullToNil( d1.objectForKey("first_airdate") )
                
                if date2 == nil
                {
                        
                }
                else
                {
                date = d1.objectForKey("first_airdate") as! NSString
                }
                
                }
                drama = drama.stringByAppendingFormat(", %d Seasons", seasons.count)
                self.TypeLbl.text = drama as String
                Description.text = jsonData1.objectForKey("overview") as! String
                
            //print(array1)
            }
            catch
            {
                
            }
          }
          catch
          {
            
          }
          }
          else
          {
            result.removeAllObjects()
            KVNProgress.show()
            availableon.removeAllObjects()
            linkname.removeAllObjects()
            downloadl.removeAllObjects()
            Episodes.text = "Available On"
            self.SeasonsTextField.hidden = true
            self.SeasonsTableView.hidden = true
            self.SeasonsButton.hidden = true
            let UrlString1 : NSString = NSString(format: "\(baseURL)movie/%@",Idstring)
            let url1 = NSURL(string: UrlString1 as String)
            let data1 = NSData(contentsOfURL: url1!)
            
            do
            {
               let jsonData1 = try NSJSONSerialization.JSONObjectWithData(data1!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                print(jsonData1)
                
                var array1 = jsonData1.objectForKey("title") as! String
                let array2 = jsonData1.objectForKey("rating") as! String
                array1 = array1.stringByAppendingFormat(", %@", array2)
                TitleLbl.text = array1 as String
                //artwork_208x117
                let imgstring: String = (jsonData1["poster_120x171"] as! String)
                self.ImageforTVMV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imgstring)!)!)
                //let network = jsonData1.objectForKey("network")
               
                let geners = jsonData1.objectForKey("genres") as! NSArray
                for var d in geners
                {
                    drama = d.objectForKey("title") as! NSString
                     NetworkLbl.text = drama as? String
                }
                let actress = jsonData1.objectForKey("cast") as! NSArray
                for var dd in actress {
                   // act = dd.objectForKey("name") as! NSString
                }
                
                let sub = jsonData1.objectForKey("purchase_ios_sources") as! NSArray
                for var dic in sub {
                    let sss = dic.objectForKey("display_name") as! String
                    let Ss = dic.objectForKey("link") as! String
                    let download = dic.objectForKey("app_download_link") as! String
                    availableon.addObject(sss)
                    linkname.addObject(Ss)
                    downloadl.addObject(download)
                }
                
                
                let a1 = jsonData1.objectForKey("subscription_ios_sources") as! NSArray
                for var d1 in a1
                {
                    let Link1 = d1.objectForKey("display_name")
                    availableon.addObject(Link1!)
                    let Link2 = d1.objectForKey("link")
                    linkname.addObject(Link2!)
                    let  download1 = d1.objectForKey("app_download_link") as! NSString
                    downloadl.addObject(download1)
                    
                }
                
                let a11 = jsonData1.objectForKey("purchase_ios_sources") as! NSArray
                
                for var d11 in a11
                {
                    let Link11 = d11.objectForKey("display_name")
                    availableon.addObject(Link11!)
                    let Link22 = d11.objectForKey("link")
                    linkname.addObject(Link22!)
                    let download1 = d11.objectForKey("app_download_link") as! NSString
                    downloadl.addObject(download1)
                    
                    
                }//tv_everywhere_ios_sources
                
                let a111 = jsonData1.objectForKey("tv_everywhere_ios_sources") as! NSArray
                for var d111 in a111
                {
                    let Link111 = d111.objectForKey("display_name")
                    availableon.addObject(Link111!)
                    let Link221 = d111.objectForKey("link")
                    linkname.addObject(Link221!)
                    let download1 = d111.objectForKey("app_download_link") as! NSString
                    downloadl.addObject(download1)
                    
                    
                }//free_ios_sources
                
                let a112 = jsonData1.objectForKey("free_ios_sources") as! NSArray
                
                for var d112 in a112
                {
                    let Link111 = d112.objectForKey("display_name")
                    availableon.addObject(Link111!)
                    let Link221 = d112.objectForKey("link")
                    linkname.addObject(Link221!)
                    let download1 = d112.objectForKey("app_download_link") as! NSString
                    downloadl.addObject(download1)
                    
                }
               
                availableon.enumerateObjectsUsingBlock({ object, index, stop in
                    if !self.result.containsObject(object) {
                        self.result.addObject(object)
                    }
                })
                
                //https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/movie/50362/related
               
                let UrlString11 : NSString = NSString(format: "\(baseURL)movie/%@/related",Idstring)
                let url11 = NSURL(string: UrlString11 as String)
                let data11 = NSData(contentsOfURL: url11!)
                
                do {
                    
                    self.TypeLbl.text = act as String
                    Description.text = jsonData1.objectForKey("overview") as! String
                    
                    //print(array1)
                   }
                 catch
                 {
                    
                 }
 
               }
            catch
            {
                
            }
       // https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/show/617
        
        }
        if (compare .isEqualToString("compare"))
        {
          self.SeasonsTextField.text = "Season 1"
          Collectionview1.delegate = self
          Collectionview1.dataSource = self
          number = 1
          let UrlString11 : NSString = NSString(format: "\(baseURL)show/%@/episodes/%@/0/25/all/all",Idstring,number)
          let url11 = NSURL(string: UrlString11 as String)
          let data11 = NSData(contentsOfURL: url11!)
        
        do
         {
            
          let jsonData112 = try NSJSONSerialization.JSONObjectWithData(data11!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
          let array1 = jsonData112.objectForKey("results") as! NSArray
           
          for var Dev in array1
          {
                
                let epn = Dev.objectForKey("episode_number")
                episodenumber.addObject(epn!)
                let epI = Dev.objectForKey("id")
                episodeId.addObject(epI!)
                let ept = Dev.objectForKey("title")
                episodeTitle.addObject(ept!)
                let imgstring: String = (Dev["thumbnail_400x225"] as! String)
                let img = UIImage(data: NSData(contentsOfURL: NSURL(string: imgstring)!)!)
                thumbnail.addObject(img!)
                let epdate = Dev.objectForKey("first_aired")
                first_aired.addObject(epdate!)
                
            }
           
            //var rr = jsonData112.objectForKey("episode")?.valueForKey("some")
            Collectionview1.reloadData()
            print(jsonData112)
        }
        catch
        {
            
        }
        }
       
    }
    
    // MARK: - UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return seasons.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
     return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
     
              //print(sea)
        cell.textLabel?.text = "Season \(SeasonNumber.objectAtIndex(indexPath.row))"
        
        return cell
        
    }
    override func viewDidDisappear(animated: Bool)
    {
        KVNProgress.dismiss()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        KVNProgress.show()
        episodenumber.removeAllObjects()
        episodeTitle.removeAllObjects()
        thumbnail .removeAllObjects()
        first_aired.removeAllObjects()
        episodeId.removeAllObjects()
        SeasonsTableView.hidden = true
        KVNProgress.showWithStatus("Loading...")
        
        Collectionview1.delegate = self
        Collectionview1.dataSource = self
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        self.SeasonsTextField.text = cell.textLabel?.text
         number = SeasonNumber.objectAtIndex(indexPath.row) as! NSNumber
        print(number)
        let UrlString11 : NSString = NSString(format: "\(baseURL)show/%@/episodes/%@/0/25/all/all",Idstring,number)
        
        let url11 = NSURL(string: UrlString11 as String)
        let data11 = NSData(contentsOfURL: url11!)
        
        do {
            
            let jsonData112 = try NSJSONSerialization.JSONObjectWithData(data11!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            let array1 = jsonData112.objectForKey("results") as! NSArray
            for var Dev in array1
            {
                let epn = Dev.objectForKey("episode_number")
               episodenumber.addObject(epn!)
               
                let epI = Dev.objectForKey("id")
                episodeId.addObject(epI!)
                let ept = Dev.objectForKey("title")
                episodeTitle.addObject(ept!)
               
                let imgstring: String = (Dev["thumbnail_400x225"] as! String)
                let img = UIImage(data: NSData(contentsOfURL: NSURL(string: imgstring)!)!)
                thumbnail.addObject(img!)
               
                let epdate = Dev.objectForKey("first_aired")
                first_aired.addObject(epdate!)
                
                
            }
            
           Collectionview1.reloadData()
            print(jsonData112)
        }
        catch
        {
            
        }

        
        KVNProgress.dismiss()
        
       // https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/show/300/episodes/1/0/25/all/all
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - CollectionView

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (compare .isEqualToString("compare"))
        {
       
        return episodenumber.count
        }
        else
        {
             return result.count
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath) as! CollectionViewCell
        if (compare .isEqualToString("compare"))
        {
            cell.EpisodeLbl.hidden = false
            cell.DateLbl.hidden = false
            cell.AvailableLBL.hidden = true
        cell.Img1.image = thumbnail.objectAtIndex(indexPath.row) as? UIImage
        cell.DateLbl.text = first_aired.objectAtIndex(indexPath.row) as? String
        
        cell.EpisodeLbl.text = "Episode \(episodenumber.objectAtIndex(indexPath.row))-\(episodeTitle.objectAtIndex(indexPath.row))"
        }
        else
        {
            cell.EpisodeLbl.hidden = true
            cell.DateLbl.hidden = true
            cell.AvailableLBL.hidden = false
            //cell.Img1.image = UIImage(named: "")
           
            

            cell.AvailableLBL.text = result.objectAtIndex(indexPath.row) as? String
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
     let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        if (compare .isEqualToString("compare"))
        {

        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let episode = story.instantiateViewControllerWithIdentifier("episode") as! EpisodesClass
        
        //https://api-public.guidebox.com/v1.43/US/rKOGHIqFtHNSC95cukSX25jbba920Ky0/episode/29551
        
        
      
        cell.Img1.image = thumbnail.objectAtIndex(indexPath.row) as? UIImage
        
        episode.img1 = (thumbnail.objectAtIndex(indexPath.row) as? UIImage)!//cell.Img1.image!
        episode.title1 = cell.EpisodeLbl.text!
        episode.titleseas = array3
        let number11 = episodeId.objectAtIndex(indexPath.row) as! NSNumber
        episode.IDE = String(number11)
        episode.seasonnum = SeasonsTextField.text!
        episode.date = cell.DateLbl.text!
        episode.idstring1 = Idstring
        episode.seasonnumber = String(number)
        self.navigationController?.pushViewController(episode, animated: true)
        }
        else
        {
            let String1 = linkname.objectAtIndex(indexPath.item) as! NSString
            
            let t_st = ":"
            let range = String1.rangeOfString(t_st, options: .CaseInsensitiveSearch) as NSRange
            //let rang = [String1 rangeOfString:t_st options:NSCaseInsensitiveSearch] as NSRange
            var subString: String = String1.substringWithRange(NSMakeRange(0, String1.rangeOfString(":").location))
            print(subString)
            
            subString = subString.stringByAppendingString("://")
            print(subString)
            if range.length == t_st.characters.count {
                NSLog("done")
            }
            else {
                NSLog("not done")
            }
            
            
            print(String1)
            //let Str = Linkarray.objectAtIndex(indexPath.row) as! String
            
            
            if UIApplication.sharedApplication().canOpenURL(NSURL(string:subString)!)
            {
                UIApplication.sharedApplication().openURL(NSURL(string: String1 as String)!)
            }
                // }
            else
            {
                //print(cell.LinkdetailsLbl.text)
                //print(LinkName.objectAtIndex(indexPath.item))
                let alert = UIAlertController(title: "Alert!", message: "You don't have this Application in your TV Please Install and Try again", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                    UIApplication.sharedApplication().openURL(NSURL(string: self.downloadl[indexPath.item] as! String)!)
                }))
                alert.addAction(UIAlertAction(title: "No, Thanks", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                    
                }))
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.presentViewController(alert, animated: true, completion: { _ in })
                })
            }
//            if UIApplication.sharedApplication().canOpenURL(NSURL(string: linkname[indexPath.item] as! String)!) {
//                UIApplication.sharedApplication().openURL(NSURL(string: linkname[indexPath.item] as! String)!)
//            }
//            else
//            {
//                let alert = UIAlertController(title: "Alert!", message: "You don't have this Application in your TV Please Install and Try again", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
//                  UIApplication.sharedApplication().openURL(NSURL(string: self.downloadl[indexPath.item] as! String)!)
//                }))
//                alert.addAction(UIAlertAction(title: "No, Thanks", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
//                    
//                }))
//                dispatch_async(dispatch_get_main_queue(), {() -> Void in
//                    self.presentViewController(alert, animated: true, completion: { _ in })
//                })

                
           // }
        }
        
    }
        
    
    @IBAction func SeasonsButton(sender: AnyObject)
    {
        SeasonsTableView.hidden = false
        
        
    }
}
