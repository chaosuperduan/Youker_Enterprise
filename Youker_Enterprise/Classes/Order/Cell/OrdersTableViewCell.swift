//
//  OrdersTableViewCell.swift
//  youke
//  Created by Duan Chao on 2018/5/17.
//  Copyright © 2018年 M2Micro. All rights reserved.

import UIKit
enum OrderOperationType {
    //enum：付款，评价。
    case PayOperation,refuseOp,commmentOP
    
    
}

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var addressBTN: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var LeadConstraint: NSLayoutConstraint!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var payButton: UIButton!
    var opCallBack:((OrderOperationType)->())?
    var naviBack:(()->())?
    var isEdite: Bool = false{
        didSet{
           
            if(isEdite){
                if(self.mode?.orders?.is_Finish == 1){
                    UIView.animate(withDuration: 1) {
                        self.editBtn.isHidden = false
                        self.LeadConstraint.constant = 40
                    }
                    
                }
               
                
            }else{
                UIView.animate(withDuration: 1) {
                    self.editBtn.isHidden = true
                    self.LeadConstraint.constant = 20
                }
                
            }
           
        }
    }
    var mode :OrderMode?{
        
        didSet{
            addressBTN.setTitle(mode?.hotelInfo?.hotel_Address, for: .normal)
            titleLabel.text = mode?.hotelInfo?.hotel_Name
            //subTitleLabel.text = mode?.hotelInfo?.hotel_Name
            priceLabel.text = "\(String(describing: mode!.orders!.price))" + "元"
            timeLabel.text = (mode?.orders?.startTime)!+"至"+(mode?.orders?.endTime)!
            countLabel.text = "\(String(describing: mode!.orders!.booking_Num))"
            
            if mode?.orders?.is_Finish == 0 {
                finishLabel.text = "正在进行中"
            }else{
                finishLabel.text = "交易完成"
            }
            let url = URL(string: (mode?.url) ?? "hotel")
            
            iconImageView.kf.setImage(with: url)
            switch mode?.orders?.order_State {
            case 10:
                
                payButton.setTitle("点击付款", for: .normal)
                break
            case 12:
                payButton.setTitle("点击退款", for: .normal)
                break
            case 13:
                payButton.setTitle("已入住", for: .normal)
                
                break
            case 18:
                payButton.setTitle("待评价", for: .normal)
                
                break
            case 99:
                payButton.setTitle("交易关闭", for: .normal)
                payButton.setTitleColor(UIColor.gray, for: .normal)
                payButton.backgroundColor = UIColor.white
                break
                
            default:
                payButton.isHidden = true
                break
            }
            if mode?.isDelete == true {
                
                if(isEdite){
                  
                  self.editBtn.setBackgroundImage(UIImage.init(named: "isselect"), for: .normal)
                }
            }else{
                
                self.editBtn.setBackgroundImage(UIImage.init(named: "unsel"), for: .normal)
                
            }
            
        }
    }
    
   
    
    
    @IBAction func PayButtonClick(_ sender: UIButton) {
        switch mode?.orders?.order_State {
        case 10:
            opCallBack!(OrderOperationType.PayOperation)
            break
        case 12:
            opCallBack!(OrderOperationType.refuseOp)
            break
       
            
            
        default:
            break
            
        }
        
    }
    
    
    @IBAction func startNavi(_ sender: Any) {
        naviBack!()
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
