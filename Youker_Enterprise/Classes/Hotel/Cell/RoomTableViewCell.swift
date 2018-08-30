//
//  RoomTableViewCell.swift
//  youke
//
//  Created by keelon on 2018/6/26.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var breakfeastLabel: UILabel!
    @IBOutlet weak var windowLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    var callBack:((_ room:Room)->())?
    var price:NSInteger = 0
    var room:Room?{
        didSet{
            if room?.has_Window == 1 {
                self.windowLabel.text = "有窗"
            }else{
                self.windowLabel.text = "有窗"
                
            }
               roomLabel.text = room?.room_Name
            if (room?.pictures.count)!>0 {
                iconImageView.kf.setImage(with: URL.init(string: (room?.pictures[0])!))
            }
            
            if room?.has_Breakfast == 1 {
                self.breakfeastLabel.text = "含早餐"
            }else{
                self.breakfeastLabel.text = "不含早餐"
            }
            
            let priceString = NSMutableAttributedString.init(string:"原价：" + "\(String(describing: room!.original_Price))")
            
            priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
             discountLabel.text = "￥" + "\(price)" + "/天"
            priceLabel.attributedText = priceString
           
            areaLabel.text = "房间面积:"+"\(room!.area)"+"㎡"
            bedLabel.text = "床的尺寸" + "\(room!.bed_Length)"+"x"+"\(room!.bed_Width)"+"m"
            }
        
    }
    
    @IBAction func book(_ sender: Any) {
        if (callBack != nil) != nil {
            callBack!(room!)
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
