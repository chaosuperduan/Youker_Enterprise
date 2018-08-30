//
//  TitleTableViewCell.swift
//  youke
//
//  Created by keelon on 2018/7/7.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    var mode:Room?{
        
        didSet{
//            contentLabel.text = "\(String(describing: mode?.bookSUM))"
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var plusBTN: UIButton!
    
    @IBOutlet weak var minusBTN: UIButton!
    var callback:((NSInteger)->())?
    var titleType:NSInteger = -1{
        didSet{
            switch titleType {
                
            case 0:
                
                self.plusBTN.isHidden = false
                self.minusBTN.isHidden = false
                self.contentTF.text = "1"
               // self.contentTF.keyboardType = .
                
                break
                
            case 1:
                self.contentTF.text = UserAccount.loadUserAccount()?.nick_Name
                break
            case  2:
                
                self.contentTF.keyboardType = .phonePad
                self.contentTF.text = UserAccount.loadUserAccount()?.phone_Number
                
                break
                
            default:
                break
            }
            
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func reduce(_ sender: Any) {
        if (mode?.bookSUM)! > 1{
            mode?.bookSUM = (mode?.bookSUM)!-1
            contentTF.text = "\(String(describing: mode!.bookSUM))"
            self.callback!(mode!.bookSUM)
        }
    }
    @IBAction func add(_ sender: Any) {
        if (mode?.bookSUM)!<(mode?.room_Count)! {
             mode?.bookSUM = (mode?.bookSUM)!+1
             contentTF.text = "\(String(describing: mode!.bookSUM))"
            self.callback!(mode!.bookSUM)
        }
    }
}
