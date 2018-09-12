//
//  LimitCell.swift
//  Youker_Enterprise
//  Created by keelon on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.

import UIKit

class LimitCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addBTN: UIButton!
    @IBOutlet weak var imgView: UIImageView!
//    var mode:EditGroup?{
//        didSet{
//
//            titleLabel.text = mode?.title
//            imgView.image = UIImage.init(named: (mode?.imge)!)
//
//        }
//    }
    
    var mode:UserGroupModel?{
        didSet{
            imgView.image = UIImage.init(named: (mode?.imge)!)
            titleLabel.text = mode?.group_Name
            if mode?.company_Id == -7 {
                self.addBTN.isHidden = false
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
