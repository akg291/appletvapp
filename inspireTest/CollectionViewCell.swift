//
//  CollectionViewCell.swift
//  POCApp
//
//  Created by Harry_w on 5/5/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var AvailableLBL: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var EpisodeLbl: UILabel!
    @IBOutlet weak var Img1: UIImageView!
    
    override func awakeFromNib() {
        self.Img1.adjustsImageWhenAncestorFocused = true;
    }
}
