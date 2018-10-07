//
//  Order_DetailViewController.swift
//  youke
//
//  Created by keelon on 2018/7/9.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class Order_DetailViewController: BaseViewController {
    @IBOutlet weak var InvoiceBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    @IBOutlet weak var hotleType_label: UILabel!
    var orderId :NSInteger = 0
    
    @IBOutlet weak var book_personLabel: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    
    @IBOutlet weak var leaveTimeLabel: UILabel!
    //订单详情。
    @IBOutlet weak var BookTimeLabel: UILabel!
    
    @IBOutlet weak var OrderNolabel: UILabel!
    
    @IBOutlet weak var BookingDateLabel: UILabel!
    @IBOutlet weak var secondView: UIView!
    
    
    
    @IBOutlet weak var countLabel: UILabel!
   
    @IBOutlet weak var PriceBtn: UIButton!
    
    @IBOutlet weak var payButton: UIButton!
    var roomType:NSInteger = 0
    @objc var recordOrder:orderRecord = orderRecord()
    var mode:OrderMode?{
        didSet{
            
          refreshUI()
        }
    }
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "订单详情"
        
        super.viewDidLoad()
        loadDatas()

    }
    
    
    func loadDatas(){
        
        var paramer = NSMutableDictionary()
        paramer["orderId"] = self.orderId
        paramer["userId"] = UserAccount.loadUserAccount()?.user_Id
        paramer["x"] = UserAccount.loadUserAccount()?.longtitude
        paramer["y"] = UserAccount.loadUserAccount()?.latitude
        paramer["token"] = UserAccount.loadUserAccount()?.token
        OrderViewModel.shareInstance.load_detailOrders(params: paramer as! [String : AnyObject], orVC: self)
        
    }
    
    
    func refreshUI(){
       
        iconImageView.kf.setImage(with:URL.init(string: (mode?.url)!))
        countLabel.text = "\(String(describing: mode!.orders!.booking_Num))"
        hotelNameLabel.text = self.mode?.hotelInfo?.hotel_Name
        hotleType_label.text = self.mode?.roomInfo?.room_Name
        book_personLabel.text = mode?.booking_Peoples
        checkInTime.text =  TimeTool.getTimeStrWithInt(time: (mode?.orders?.booking_CheckIn_Date)!)
        leaveTimeLabel.text = TimeTool.getTimeStrWithInt(time: (mode?.orders?.booking_Leave_Date)!)
        OrderNolabel.text = "\(mode!.orders!.order_Number)"
        BookingDateLabel.text = TimeTool.getTimeStrWithInt(time: (mode?.orders?.order_Date)!)
        
        switch mode?.orders?.order_State {
        case 10:
            
            payButton.setTitle("点击付款", for: .normal)
            break
        case 12:
            payButton.setTitle("点击退款", for: .normal)
            break
        case 13:
            payButton.setTitle("评价", for: .normal)
            break
        case 18:
            payButton.setTitle("评价", for: .normal)
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
        
        let view = OrderDetailSecondView.LoadFromNib()
        view.callback = { index in
            
            
            if index == 1 {
               
//                let vc = GPSNaviViewController();               vc.end_longtitude = CGFloat((self.mode?.hotelInfo?.detail_Position_X)!)
//
//                vc.end_latitude = CGFloat((self.mode?.hotelInfo?.detail_Position_Y)!)
//                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                var url1 = NSURL(string: "tel://" + (self.mode?.hotelInfo!.reception_Phone)!)
                UIApplication.shared.openURL(url1! as URL)
            }
        }
        view.frame = secondView.bounds
        view.mode = self.mode
        secondView.addSubview(view)
        
        PriceBtn.setTitle("￥:"+"\(mode!.orders!.price)", for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    @IBAction func HotelClick(_ sender: Any) {
        
       let vc = OrderHotelViewController()
        vc.mode = self.mode
        vc.roomType = self.roomType
        vc.recordOrder = self.recordOrder
self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func showDetail(_ sender: Any) {
        let popView = ZXPopView.init(frame:self.view.bounds)
        let priceView = PriceDetailView.LoadFromNib()
        priceView.frame = CGRect.init(x: 0, y: KScreenH-313, width: KScreenW, height: 313)
        priceView.mode = self.mode
        popView.contenView = priceView
        popView.showInView(view: self.view)
        
        
    }
    
    
    @IBAction func operation(_ sender: Any) {
        
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
                
                
                payMode.shareInstance.Book(isAliPay: false, priceToken: nil, roomType: self.roomType, recordOrder: self.recordOrder, bookSum: self.recordOrder.booking_Num, same_Type: 0)
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
                payMode.shareInstance.Book(isAliPay: true, priceToken: nil, roomType: self.roomType, recordOrder: self.recordOrder, bookSum: self.recordOrder.booking_Num, same_Type: 0)
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
    
    
    //预约发票。
    
    @IBAction func invoiceClick(_ sender: Any) {
        
        
        let popView = ZXPopView.init(frame: self.view.bounds)
        let actionView = ActionView.LoadFromNib()
        actionView.callBack = { isdone in
            if isdone {
//                self.doneInvoice()
                
                
                popView.dismissView()
            }else{
                
                popView.removeFromSuperview()
                
            }
            
        }
        actionView.title = "是否开具发票"
        actionView.subtitle = "注意:开具发票之后不可退款"
        
         actionView.frame = CGRect.init(x: (KScreenW-325)/2, y: (KScreenH-167)/2, width: 325, height: 167)
        popView.contenView = actionView
        popView.isCenter = true
        popView.showInView(view: self.view)
        
        
    }
    
    //开发票
    
    func doneInvoice(){
        let params = NSMutableDictionary()
        params["orderId"] =
    InvoiceViewModel.sharedInstance.GetInvoice(params: params as! [String : AnyObject], orVC: self, callback1: {
                
            })
       
    }
    
    func showInvoiceView(){
        
        let popView = ZXPopView.init(frame: self.view.bounds)
        let acti = InvoiceView.LoadFromNib()
        acti.callBack = { isdone in
            if isdone {
                
                
                popView.dismissView()
            }else{
                
                popView.removeFromSuperview()
                
            }
            
        }
        
        acti.frame = CGRect.init(x: (KScreenW-346)/2, y: (KScreenH-286)/2, width: 346, height: 286)
        
        popView.contenView = acti
        popView.isCenter = true
        popView.showInView(view: self.view)
        
    }
}



