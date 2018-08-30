//
//  HotelListTableViewCell.swift
//  youke
//
//  Created by keelon on 2018/5/26.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
import Kingfisher
class HotelListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var maxOrderDateLabel: UILabel!
    
    
    @IBOutlet weak var disCountPriceLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    var hotel:HotelModel?{
        didSet{
          titleLabel.text = hotel?.hotel_Name
            districtLabel.text = "区域:" + (hotel?.district)!
            maxOrderDateLabel.text = hotel?.maxOrderDate
            let priceString = NSMutableAttributedString.init(string:"原价：" + "\(String(describing: hotel!.original_Price))")
            
        priceString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
            priceLabel.attributedText = priceString
         //disCountPriceLabel.text =
            
            if (hotel?.distance)! > 1000.1 as! Double {
                let str = String.init(format: "%.2fkm", hotel!.distance/1000)
                //distanceLabel.text = str
                distanceLabel.setTitle(" " + str, for: .normal)
                
            }else{
                let str = " "+"\(hotel!.distance)" + "m"
                distanceLabel.setTitle(str, for: .normal)
            }
            scoreLabel.text = "\(hotel!.service_Score)"
            guard let str:String = hotel?.pic else {
                return
            }
         
            let url = URL(string: str)
            
            iconImageView.kf.setImage(with: url)
            
        }
    }
    var mode:SearchParamModel?{
        didSet{
            disCountPriceLabel.text = "实付:￥" + "\(String(describing: mode!.price))" + "元"
            //timeLabel.text = (mode?.checkInDate)! + "至" + (mode?.leaveDate!)!
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
