 //
//  ManageUserCellTableViewCell.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ManageUserCellTableViewCell: UITableViewCell {
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    var mode:User?{
        didSet{
          self.titleLabel.text = mode?.employee_Name
            self.subTitleLabel.text = String.init(format: "(@%)", (mode?.phoneNumber)!)
            
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
