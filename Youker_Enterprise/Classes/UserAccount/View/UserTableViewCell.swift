//
//  UserTableViewCell.swift
//  youke
//
//  Created by Duan Chao on 2018/5/14.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    var callbak:((_ str:String,_ back:()->())->())?

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var SubtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        nameLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
     }
    @objc func textFieldDidChange(){
        if self.callbak != nil{
            self.callbak!(nameLabel.text!,{
                
                
            })
            
        }
     }
   
    
}
