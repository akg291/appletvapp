//
//  Moviecell.swift
//  POCApp
//
//  Created by Harry_w on 5/12/16.
//  Copyright © 2016 Harry. All rights reserved.
//

import UIKit

class Moviecell: UICollectionViewCell {
    
    @IBOutlet weak var ImageN: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    override func awakeFromNib() {
        ImageN.adjustsImageWhenAncestorFocused = true
    }
}
