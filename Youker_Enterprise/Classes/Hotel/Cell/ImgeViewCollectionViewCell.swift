//
//  ImgeViewCollectionViewCell.swift
//  youke
//
//  Created by Duan Chao on 2018/5/18.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class ImgeViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var picture:String?{
        
        didSet{
            
            let url = URL(string: picture!)
            
            iconImageView.kf.setImage(with: url)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
