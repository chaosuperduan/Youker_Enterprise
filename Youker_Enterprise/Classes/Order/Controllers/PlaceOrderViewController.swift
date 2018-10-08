//
//  PlaceOrderViewController.swift
//  youke
//
//  Created by keelon on 2018/6/26.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
let titleCell = "titleCell"
class PlaceOrderViewController: UIViewController {
let titles = ["房间数","入住人","联系手机"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var dayCount:NSInteger = 0
    var params:SearchParamModel?{
        didSet{
            dayCount = NSDate.daysCalculate(params?.checkInDate, endDays: params?.leaveDate)
        }
        
    }
    var priceToken:String?
    var recordOrder:orderRecord?
    @IBOutlet weak var priceButton: UILabel!
    lazy var payView:PayView = {
        return PayView.LoadFromNib()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(dealResult), name: NSNotification.Name.init("paySuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dealFailResult), name: NSNotification.Name.init("payFail"), object: nil)
        setUpUI()
    }
    //选择优惠券
    @IBAction func coupon(_ sender: Any) {
       SVProgressHUD.showSuccess(withStatus: "优惠券功能，正在开发中，敬请期待")
        return
       let popview = ZXPopView.init(frame: self.view.bounds)
       let selectView = SelectCouponView.LoadFromNib()
       selectView.frame = CGRect.init(x: 0, y: KScreenW - 300, width: KScreenW, height:300 )
       selectView.setUpUI()
       
       popview.contenView = selectView//
       popview.showInView(view: self.view)
        
    }
    
    
    @IBAction func DetailShow(_ sender: Any) {
        
        
    }
    //处理。
    @objc func dealResult(){
        self.navigationController?.popToRootViewController(animated: true)
        SVProgressHUD.showSuccess(withStatus: "支付成功，请到我的订单界面查看详情")
      present(FWNavigationController.init(rootViewController: MyOrdersViewController()), animated: true, completion: nil)
    }
    @objc func dealFailResult(){
        self.navigationController?.popToRootViewController(animated: true)
        SVProgressHUD.showSuccess(withStatus: "支付失败，请到我的订单支付")
        present(FWNavigationController.init(rootViewController: MyOrdersViewController()), animated: true, completion: nil)
        
    }
    
    
    
    //下单。
    
    @IBAction func submit(_ sender: Any) {
        let popview = ZXPopView.init(frame: self.view.bounds)
        
        self.payView.frame = CGRect.init(x: 0, y: KScreenW - 300, width: KScreenW, height:300 )
        popview.contenView = self.payView
        popview.showInView(view: self.view)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var mode:Room?
    func setUpUI(){
        self.roomLabel.text = mode?.room_Name
        
       
        let m = (mode?.bookSUM)!*NSInteger((params?.price)!)*dayCount
        self.priceButton.text = "￥" + "\(m)"
        
        //self.priceButton.text =
        self.timeLabel.text  = "入住时间" + (params?.checkInDate)! + "至" + (params?.leaveDate)!
        self.navigationItem.title = "预订下单"
        tableView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: titleCell)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.reloadData()
        
        self.payView.callBack = {(payStyle) in
            if (payStyle == PayStyle.WeixinPay) {
                self.mode?.same_Type
                payMode.shareInstance.Book(isAliPay: false, priceToken: nil, roomType: (self.mode?.room_Type)!, recordOrder: self.recordOrder!, bookSum: (self.mode!.bookSUM),same_Type:(self.mode!.same_Type))
            }else{
                payMode.shareInstance.Book(isAliPay: true, priceToken: nil, roomType: (self.mode?.room_Type)!, recordOrder: self.recordOrder!, bookSum: (self.mode?.bookSUM)!, same_Type: (self.mode?.same_Type)!)
            }
        }
        
    }
}
extension PlaceOrderViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: titleCell, for: indexPath) as! TitleTableViewCell
        cell.titleLabel.text = titles[indexPath.row]

        cell.titleType = indexPath.row
        if indexPath.row == 0 {
            cell.callback = { price in
                let str :String = "￥"+"\(self.dayCount*price*(self.params?.price)!)"
              self.priceButton.text = str
            }
        }
        cell.mode = self.mode
        
        
       return cell
    }
}
