//
//  OrderHotelViewController.swift
//  youke
//
//  Created by keelon on 2018/7/11.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class OrderHotelViewController: UIViewController {
    var mode:OrderMode?
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var operationButton: UIButton!
    
    @IBOutlet weak var priceButton: UIButton!
    
    @IBOutlet weak var IntroduceTextView: UITextView!
    var roomType:NSInteger = 0
    @objc var recordOrder:orderRecord = orderRecord()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpUI(){
        self.navigationItem.title = "订单详情"
        if self.mode != nil {
            self.priceButton.setTitle("￥:"+"\(mode!.orders!.price)", for: .normal)
        }
      
      let headerView =  OrderDetailHeader.LoadFromNib()
      headerView.frame = view1.bounds
      headerView.mode = self.mode
      view1.addSubview(headerView)
    let secV = OrderDetailSecondView.LoadFromNib()
     secV.frame = view2.bounds
     secV.mode = self.mode
     view2.addSubview(secV)
    let fa = facilitiesView()
    fa.frame = view3.bounds
    fa.mode = self.mode?.room
    view3.addSubview(fa)
        self.IntroduceTextView.text = mode?.hotelInfo?.hotel_Introduce!
        switch mode?.orders?.order_State {
        case 10:
            
            operationButton.setTitle("点击付款", for: .normal)
            break
        case 12:
            operationButton.setTitle("点击退款", for: .normal)
            break
        case 13:
            operationButton.setTitle("已入住", for: .normal)
            break
        case 18:
            operationButton.setTitle("评价", for: .normal)
            break
        case 99:
            operationButton.setTitle("交易关闭", for: .normal)
           operationButton.setTitleColor(UIColor.gray, for: .normal)
            operationButton.backgroundColor = UIColor.white
            break
            
        default:
            operationButton.isHidden = true
            break
        }
    }
    
    
    //付款。
    func PayOrder(){
        let payView = PayView.LoadFromNib()
        payView.frame = CGRect.init(x: 0, y: kScreenH-290, width: KScreenW, height: 285)
        payView.backgroundColor = UIColor.white
        //self.tableView.addSubview(self.payView)
        payView.show()
        payView.callBack = {(payStyle) in
            if (payStyle == PayStyle.WeixinPay) {
                self.recordOrder.booking_Leave_Date = self.mode?.orders?.endTime
                self.recordOrder.booking_CheckIn_Date = self.mode?.orders?.startTime
                self.recordOrder.hotel_Id = (self.mode?.hotelInfo?.hotel_Id)!
                //self.recordOrder.
                self.recordOrder.booking_Num = (self.mode?.orders?.booking_Num)!
                self.recordOrder.order_Id = (self.mode?.orders?.order_Id)!
                
                // self.recordOrder.user_Id = self.selectMode?.orders?.user_Id as! NSNumber
                self.roomType = (self.mode?.roomInfo?.room_Type)!
                
                
                payMode.shareInstance.Book(isAliPay: false, priceToken: nil, roomType: self.roomType, recordOrder: self.recordOrder, bookSum: self.recordOrder.booking_Num)
                payView.close()
                
            }else{
                
                self.recordOrder.booking_Leave_Date = self.mode?.orders?.endTime
                self.recordOrder.booking_CheckIn_Date = self.mode?.orders?.startTime
                self.recordOrder.hotel_Id = (self.mode?.hotelInfo?.hotel_Id)!
                //self.recordOrder.
                self.recordOrder.booking_Num = (self.mode?.orders?.booking_Num)!
                self.recordOrder.order_Id = (self.mode?.orders?.order_Id)!
                
                // self.recordOrder.user_Id = self.selectMode?.orders?.user_Id as! NSNumber
                self.roomType = (self.mode?.roomInfo?.room_Type)!
                
                
                payMode.shareInstance.Book(isAliPay: true, priceToken: nil, roomType: self.roomType, recordOrder: self.recordOrder, bookSum: self.recordOrder.booking_Num)
                payView.close()
            }
        }
    }
    //退款。
    func refuseOrder(){
        let param = NSMutableDictionary()
        param ["order_id"]  = self.mode?.orders?.order_Id
        param["token"] = UserAccount.loadUserAccount()?.token
        param["reason"] = "NO"
        
        OrderRefuse.shareInstance.refuseOrder(params: param as! [String : AnyObject], orVc: nil, callback1: { response ,msg in
            if(msg != nil){
                SVProgressHUD.showError(withStatus: msg)
                
                
            }else{
                
                SVProgressHUD.showSuccess(withStatus: "退款成功!")
                
            }
            
            self.navigationController?.popToRootViewController(animated: true)
            
            
        })
    }
    //评价
    
    func comment(){
        
        let popView = ZXPopView.init(frame: view.bounds)
        let commentV = commentView.LoadFromNib()
        commentV.frame = CGRect.init(x: 40, y: KScreenH, width: KScreenW-80, height: 313)
        commentV.layer.cornerRadius = 5
        commentV.layer.masksToBounds = true
        
        popView.isCenter = true
        popView.contenView = commentV
        popView.showInView(view: view)
    }
    
    @IBAction func orderClick(_ sender: Any) {
        
        switch mode?.orders?.order_State {
        case 10:
            PayOrder()
            break
        case 12:
            refuseOrder()
            
            break
        case 18:
            comment()
            break
        default:
            break
            
        }
        
    }
    
  

}
