//
//  InstrumentCollectionViewCell.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit

class InstrumentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var instrumentImageView : UIImageView?
    @IBOutlet weak var instrumentNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        instrumentImageView?.layer.cornerRadius = self.frame.height / 12.0
        instrumentImageView?.layer.masksToBounds = true
        // Initialization code
    }

}
