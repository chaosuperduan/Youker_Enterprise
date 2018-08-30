//
//  TotalTableViewController.swift
//  youke
//
//  Created by Duan Chao on 2018/5/17.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
let orderCell = "OrdersCell"
class TotalTableViewController: BaseTableViewController {
    //mode
    var DeleteOrders:[NSInteger] = [NSInteger]()
    var isAll:Bool = false{
        
        didSet{
            if isAll == true {
                for  mode in self.dataArrays {
                    if(mode.orders?.is_Finish == 1){
                        
                        mode.isDelete = true
                        self.DeleteOrders.append((mode.orders?.order_Id)!)
                    }
                    
                    
                    
                }
                
                self.tableView.reloadData()
            }else{
                for  mode in self.dataArrays {
                    mode.isDelete = false
                    
                }
                self.DeleteOrders.removeAll()
                self.tableView.reloadData()
            }
            
        }
    }
    var selectMode:OrderMode?
    var selectRoom:Room?
    @objc var recordOrder:orderRecord = orderRecord()
    //payView
    lazy var payView:PayView = {
        return PayView.LoadFromNib()
    }()
    //处理网络请求结果处理。
    var roomType:NSInteger = 0
    //var Tpview:TypeView? = TypeView()
    var state:NSInteger = -1
    
    var dataArrays:[OrderMode] = [OrderMode](){
        
        didSet{
            self.tableView.reloadData()
            
        }
    }
    // var errorMessage:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.editView.callback = { index in
            if self.isEidt {
                if(index == 0){
                    //全选。
                    self.isAll = !self.isAll
                    if(self.isAll){
                        self.editView.AllBTN.setImage(UIImage.init(named: "isselect"), for: .normal)
                    }else{
                        self.editView.AllBTN.setImage(UIImage.init(named: "unsel"), for: .normal)
                        
                    }
                    self.tableView.reloadData()
                }else{
                    //删除订单。
                    self.deleteOrders()
                }
            }
            
        }
    }
    /// mark-删除订单。
    func deleteOrders(){
        
        let data = try? JSONSerialization.data(withJSONObject: self.DeleteOrders, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        let params = NSMutableDictionary()
        params["orders"]=strJson;
        
        params["token"] = UserAccount.loadUserAccount()?.token!
        DeleteOrderViewMode.shareInstance.DeleteOrders(params: params as! [String : AnyObject], orVC: self)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        self.isEidt = false
        self.editView.removeFromSuperview()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.isEidt = false
        self.editView.removeFromSuperview()
    }
    
    override func loadDatas() {
        let param = NSMutableDictionary()
        param["userId"] = UserAccount.loadUserAccount()?.user_Id
        param["token"] = (UserAccount.loadUserAccount()?.token)!
        if state != -1 {
            param["state"] = self.state
        }
        OrderViewModel.shareInstance.loadOrders(params: param as! [String : AnyObject], orVC: self)
        self.tableView.mj_header.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrays.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: orderCell, for: indexPath) as! OrdersTableViewCell
        if cell == nil {
            cell = OrdersTableViewCell()
        }
        cell.mode = dataArrays[indexPath.row]
        cell.naviBack = {
            
//            let vc = GPSNaviViewController()
//            vc.end_longtitude = CGFloat((cell.mode?.hotelInfo?.detail_Position_X)!)
//            vc.end_latitude = CGFloat((cell.mode?.hotelInfo?.detail_Position_Y)!)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.opCallBack = {   opty in
            switch opty {
            case .PayOperation:
                self.selectMode = cell.mode
                self.PayOrder()
                break
            case  .refuseOp:
                self.selectMode = cell.mode
                self.refuseOrder()
                break
            case  .commmentOP:
                break
            default:
                break
            }
        }
        cell.isEdite = self.isEidt
        
        return cell
    }
    deinit {
        
        
        self.editView.removeFromSuperview()
        print("控制器销毁了")
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if isEidt == false {
            let vc = Order_DetailViewController()
            //vc.mode = self.dataArrays[indexPath.row]
            vc.orderId = (self.dataArrays[indexPath.row].orders?.order_Id)!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let mode =  self.dataArrays[indexPath.row]
            if(mode.orders?.is_Finish == 0){
                return
            }
            
            mode.isDelete = !mode.isDelete
            if(mode.isDelete == true){
                // mode.isDelete
                if(DeleteOrders.contains((mode.orders?.order_Id)!)){
                    
                    
                }else{
                    DeleteOrders.append((mode.orders?.order_Id)!)
                    
                }
                
            }else{
                if(DeleteOrders.contains((mode.orders?.order_Id)!)){
                    
                    var index = 0
                    for i in DeleteOrders{
                        if(mode.orders?.order_Id ==  DeleteOrders[index]){
                            break
                            
                        }else{
                            index = index+1
                            
                        }
                        
                        
                    }
                    
                    DeleteOrders.remove(at: index)
                    
                    
                }else{
                    
                }
                
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    //付款。
    func PayOrder(){
        self.payView.frame = CGRect.init(x: 0, y: kScreenH-290, width: KScreenW, height: 285)
        self.payView.backgroundColor = UIColor.white
        //self.tableView.addSubview(self.payView)
        self.payView.show()
        self.payView.callBack = {(payStyle) in
            if (payStyle == PayStyle.WeixinPay) {
                self.recordOrder.booking_Leave_Date = self.selectMode?.orders?.endTimest
                self.recordOrder.booking_CheckIn_Date = self.selectMode?.orders?.starTimest
                self.recordOrder.hotel_Id = (self.selectMode?.hotelInfo?.hotel_Id)!
                //self.recordOrder.
                self.recordOrder.booking_Num = (self.selectMode?.orders?.booking_Num)!
                self.recordOrder.order_Id = (self.selectMode?.orders?.order_Id)!
                
                // self.recordOrder.user_Id = self.selectMode?.orders?.user_Id as! NSNumber
                self.roomType = (self.selectMode?.roomInfo?.room_Type)!
                
                
                payMode.shareInstance.Book(isAliPay: false, priceToken: nil, roomType: self.roomType, recordOrder: self.recordOrder, bookSum: self.recordOrder.booking_Num)
                self.payView.close()
                
            }else{
                self.recordOrder.booking_Leave_Date = self.selectMode?.orders?.endTime
                self.recordOrder.booking_CheckIn_Date = self.selectMode?.orders?.startTime
                self.recordOrder.hotel_Id = (self.selectMode?.hotelInfo?.hotel_Id)!
                //self.recordOrder.
                self.recordOrder.booking_Num = (self.selectMode?.orders?.booking_Num)!
                self.recordOrder.order_Id = (self.selectMode?.orders?.order_Id)!
                
                // self.recordOrder.user_Id = self.selectMode?.orders?.user_Id as! NSNumber
                self.roomType = (self.selectMode?.roomInfo?.room_Type)!
                payMode.shareInstance.Book(isAliPay: true, priceToken: nil, roomType: self.roomType, recordOrder: self.recordOrder, bookSum: self.recordOrder.booking_Num)
                self.payView.close()
            }
        }
    }
    //退款。
    func refuseOrder(){
        let param = NSMutableDictionary()
        param ["order_id"]  = self.selectMode?.orders?.order_Id
        param["token"] = UserAccount.loadUserAccount()?.token
        param["reason"] = "NO"
        
        OrderRefuse.shareInstance.refuseOrder(params: param as! [String : AnyObject], orVc: self, callback1: nil)
    }
}
extension TotalTableViewController{
    func setUpUI(){
       tableView.rowHeight = 128
       tableView.register(UINib.init(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: orderCell)
       tableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "editItem"), style: .done, target: self, action: #selector(editDone))
      NotificationCenter.default.addObserver(self, selector: #selector(editDone), name: NSNotification.Name.init("EDIT"), object: nil)
    }
    //编辑模式。
    @objc func editDone(){
        
        self.isEidt = !isEidt
        if self.isEidt == true {
           //self.tableView.addSubview(self.editView)
//            self.tableView.tableFooterView = self.editView
            self.editView.removeFromSuperview();
        UIApplication.shared.keyWindow?.addSubview(self.editView)
        }else{
            self.editView.removeFromSuperview()
            
        }
        self.tableView.reloadData()
    }
    
}
