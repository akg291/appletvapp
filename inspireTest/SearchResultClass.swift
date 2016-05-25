//
//  SearchResultClass.swift
//  inspire
//
//  Created by Harry_w on 5/4/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit
//import SDImageCache
class SearchResultClass: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var Activity: UIActivityIndicatorView!
    @IBOutlet weak var MovieImage: UIButton!
    @IBOutlet weak var TvShowimage: UIButton!
    @IBOutlet weak var SearchResult: UILabel!
    var SearchString : NSString = NSString()
    var Titlestring : NSString = NSString()
    var direct : NSString = NSString()
    var array1 : NSArray = NSArray()
    var array : NSArray = NSArray()
    var datearray : NSMutableArray = NSMutableArray()
    var Imagearray : NSMutableArray = NSMutableArray()
    var Tvnamearray : NSMutableArray = NSMutableArray()
    var idarray : NSMutableArray = NSMutableArray()
var alert = UIAlertController()


    var Titlearry : NSMutableArray = NSMutableArray()

    
    @IBOutlet weak var TvShowTitleLbl: UILabel!
    
    @IBOutlet weak var TvShoworMovieLbl: UILabel!
    
    @IBOutlet weak var TvShowDate: UILabel!
    
    
    @IBOutlet weak var MovieTitleLbl: UILabel!
    
    @IBOutlet weak var MovieorTvshow: UILabel!
    
    @IBOutlet weak var MoviedateLbl: UILabel!
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    
    override func viewDidLoad()
    {
        
    
        
        collectionview.hidden = false
        collectionview.delegate = self
        collectionview.dataSource = self
        super.viewDidLoad()
        SearchResult.text = "Search Results for '\(SearchString)'"
        
        ////////////***** MOVIE URL ****/////////////
        
    var UrlString : NSString = NSString(format: "\(baseURL)search/movie/title/%@/fuzzy",self.SearchString)
     UrlString = UrlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string: UrlString as String)
        
        
        if url != nil
        {
        let data = NSData(contentsOfURL: url!)
            if data != nil
            {
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            print(jsonData)
             array = jsonData.objectForKey("results") as! NSArray
            if array.count != 0
            {
                var TitleStrng : NSString = NSString()
                var imgstring  : NSString = NSString()
                var tvname1  : NSString = NSString()
                var ids  : NSString = NSString()

                var number1 : NSNumber = NSNumber()
                for var Diction in array
                {
                    TitleStrng = Diction.objectForKey("title") as! NSString
                    Titlearry.addObject(TitleStrng)
                    tvname1 = "Movie"
                    Tvnamearray.addObject(tvname1)
                    ids = String(Diction.objectForKey("id") as! NSNumber)
                    idarray.addObject(ids)
                    number1 = Diction["release_year"] as! NSNumber
                    let st = NSString(format: "%@", number1)
                    datearray.addObject(st)
                    imgstring = Diction["poster_120x171"] as! String
                    
                    Imagearray.addObject(imgstring)
                }
            }
            else
            {

            }
            
        }
        catch
        {
            print("error")
        }
            }
            else
            {
                
            }
        }else
        {
            

        }
            ////////////// TVSHOWS URL //////////////
        
        var UrlString1 : NSString = NSString(format: "\(baseURL)search/title/%@/fuzzy",self.SearchString)
        UrlString1 = UrlString1.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url1 = NSURL(string: UrlString1 as String)
        
        if url1 != nil
        {
            let data1 = NSData(contentsOfURL: url1!)
            do {
                let jsonData1 = try NSJSONSerialization.JSONObjectWithData(data1!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    array1 = jsonData1.objectForKey("results") as! NSArray
                
                     if array1.count != 0
                       {
                         var TitleStrng1 : NSString = NSString()
                         var imgstring1  : NSString = NSString()
                         var tvname  : NSString = NSString()
                         for var Diction1 in array1
                          {
                        
                           let id1 = Diction1.objectForKey("id")
                           let StringId = id1?.stringValue
                           print(StringId)
                           TitleStrng1 = Diction1.objectForKey("title") as! NSString
                        
                           tvname  = "TV Show";
                           Tvnamearray.addObject(tvname)
                           self.datearray.addObject(Diction1.objectForKey("first_aired")!)
                           imgstring1  = Diction1["artwork_608x342"] as! String
                           Titlearry.addObject(TitleStrng1)
                           Imagearray.addObject(imgstring1)
                     
                         }
                      }
                     else
                      {
                            if Titlearry.count == 0 {
                            self.method()
                    }
                  }
                }
               catch
               {
            
              }
            }
            else
            {
            
             }
    // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(animated: Bool) {
        KVNProgress.dismiss()
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
    func method()
    {
        KVNProgress.dismiss()
        collectionview.hidden = true
        
        alert = UIAlertController(title: "Alert!", message: "Please enter correct movie or TV show name", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
            
         }))
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            
            self.presentViewController(self.alert, animated: true, completion: { _ in })
         })

    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
             return Imagearray.count
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell3", forIndexPath: indexPath) as! SearchCell
        
        //cell.activityIndicator.startAnimating()
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {() -> Void in
//            let url: NSURL = NSURL(string:  self.Imagearray[indexPath.row] as! String)!
//            
//            let imageData = NSData(contentsOfURL: url)
//            let image = UIImage(data: imageData!)
//           
//            //dispatch_sync(dispatch_get_main_queue(), {() -> Void in
//                
//            cell.ThumbnailImg.image = image
//            //cell.activityIndicator.stopAnimating()
//                
//            //})
//        })
        
         cell.TitleLbl.text = Titlearry.objectAtIndex(indexPath.row) as? String
         cell.DateLbl.text = datearray.objectAtIndex(indexPath.row) as? String
         cell.Tvname.text = Tvnamearray.objectAtIndex(indexPath.row) as? String
        let url: NSURL = NSURL(string:  self.Imagearray[indexPath.row] as! String)!
        let imageData = NSData(contentsOfURL: url)
        let image = UIImage(data: imageData!)
         cell.ThumbnailImg.image = image
        return cell
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
     {
        return 1
        
     }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
     {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SearchCell
         KVNProgress.show()
        
    if cell.Tvname.text == "TV Show"
     {
           
        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detail = story.instantiateViewControllerWithIdentifier("details") as! DetailviewClass
        
        detail.compare = "compare"
        
        var UrlString1 : NSString = NSString(format: "\(baseURL)search/title/%@/fuzzy",cell.TitleLbl.text!)
         UrlString1 = UrlString1.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.GET(UrlString1 as String, parameters: nil, success: { (operation, responceobject) in
            KVNProgress.show()
            let array1 = responceobject.objectForKey("results") as! NSArray
            
            var Diction1 = array1.objectAtIndex(0)
            
            let id1 = Diction1.objectForKey("id")
            detail.Idstring = (id1?.stringValue)!

            self.navigationController?.pushViewController(detail, animated: true)
            }, failure: { (operation, error) in
                
        })
    }
        
        
//        UrlString1 = UrlString1.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        
//        let url1 = NSURL(string: UrlString1 as String)
//        
//        let data1 = NSData(contentsOfURL: url1!)
//        
//        do {
//            let jsonData1 = try NSJSONSerialization.JSONObjectWithData(data1!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//            
//            
//            let array1 = jsonData1.objectForKey("results") as! NSArray
//            
//            var Diction1 = array1.objectAtIndex(0)
//          
//            let id1 = Diction1.objectForKey("id")
//            detail.Idstring = (id1?.stringValue)!
//            
//            }
//           catch
//           {
//            
//           }
//        
        
        
         //}
        else
        {
    
         KVNProgress.showWithStatus("Loading...")
         KVNProgress.show()
        
         let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let detail = story.instantiateViewControllerWithIdentifier("details") as! DetailviewClass
         let ss = idarray.objectAtIndex(indexPath.item)
         var UrlString : NSString = NSString(format: "\(baseURL)movie/%@",ss as! NSString)
            UrlString = UrlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            UrlString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
            
            let manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
            manager.GET(UrlString as String, parameters: nil, success: { (operation, responce) in
                KVNProgress.show()
                let id1 = responce.objectForKey("id")
                detail.Idstring = (id1?.stringValue)!
                self.navigationController?.pushViewController(detail, animated: true)
                }, failure: { (opration, error) in
                    
            })
        }
    }
//         let url = NSURL(string: UrlString as String)
//        
//        
//        
//        
//          if url != nil
//           {
//            let data = NSData(contentsOfURL: url!)
//             do
//              {
//                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
//                
//                 print(jsonData)
//                
//                let id1 = jsonData.objectForKey("id")
//                detail.Idstring = (id1?.stringValue)!
//              }
//              catch
//                {
//                
//                }
            
            
            
              // }
             // else
              //{
                // KVNProgress.dismiss()
            
//                 let alert = UIAlertController(title: "Alert!", message: "Please enter Correct movie name or Tv Show name", preferredStyle: UIAlertControllerStyle.Alert)
//                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
//                }))
//                 dispatch_async(dispatch_get_main_queue(), {() -> Void in
//                  self.presentViewController(alert, animated: true, completion: { _ in })
//                })
//               }
//             }
//            }


}
