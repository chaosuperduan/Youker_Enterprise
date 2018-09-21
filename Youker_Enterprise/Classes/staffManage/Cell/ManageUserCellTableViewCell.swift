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
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var mode:User?{
        didSet{
           setupui()
            
            
           
            }
    }
    var delete:Bool = false{
        
        didSet{
            
            if delete == true {
                self.iconImageView.image = UIImage.init(named: "delete")
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
    }
    
    func setupui(){
        self.titleLabel.text = mode?.employee_Name
        self.subTitleLabel.text = "("+(mode?.phoneNumber)!+")"
        
        if delete {
            
        }else{
            if mode?.isAdd == true {
                iconImageView.image = UIImage(named: "selected")
            }else{
                
                iconImageView.image = UIImage(named: "unselected")
                
            }
            
        }
        
        
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
