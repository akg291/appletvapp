//
//  EpisodeCell.swift
//  POCApp
//
//  Created by Harry_w on 5/6/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
    
    @IBOutlet weak var LinkdetailsLbl: UILabel!
    @IBOutlet weak var img11: UIImageView!
    @IBOutlet weak var ChannelLbl: UILabel!
    override func awakeFromNib() {
        self.img11.adjustsImageWhenAncestorFocused = true;
    }
}
