//
//  SearchCell.swift
//  POCApp
//
//  Created by Harry_w on 5/12/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
   // @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var Tvname: UILabel!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var ThumbnailImg: UIImageView!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    override func awakeFromNib() {
        ThumbnailImg.adjustsImageWhenAncestorFocused = true
        //self.initialize()
    }
     func initialize() {
        // This code is only called once
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.White)
        self.activityIndicator.center = self.ThumbnailImg.center
        self.activityIndicator.hidesWhenStopped = true
        self.ThumbnailImg.addSubview(self.activityIndicator)
    }
}
