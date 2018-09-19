//
//  InviteTableViewCell.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class InviteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var user:User?{
        
        didSet{
            titleLabel.text = (user?.employee_Name!)! + "(" + (user?.phoneNumber!)! + ")"
            if user?.timestr != nil {
                subtitleLabel.text = user?.timestr!
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
