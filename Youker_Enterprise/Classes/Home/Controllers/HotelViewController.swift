 //
//  HotelViewController.swift
//  youke
//
//  Created by Duan Chao on 2018/5/17.
//  Copyright © 2018年 M2Micro. All rights reserved.

let RoomID = "RoomID"
import UIKit
 
class HotelViewController: BaseViewController {
    
    @IBOutlet weak var distanceBtn: UIButton!
    @IBOutlet weak var daysCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeCountlabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @objc var recordOrder:orderRecord = orderRecord()
    lazy var payView:PayView = {
        return PayView.LoadFromNib()
    }()
    var priceView:PriceView = {
        return PriceView.LoadFromNib()
    }()
    
    var manager:WXApiManager = WXApiManager.shared()
    var selectRoom:Room?
    var priceToken:String?
    
    var roomType:NSInteger = 0
    var mode:HotelModel?{
        didSet{
            recordOrder.hotel_Id = (mode?.hotel_Id)!
        }
    }
    @IBOutlet weak var tableview: UITableView!
    var buInfo:businessInfo?
    
    @IBOutlet weak var HotelContenview: UIView!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBAction func PhoneClick(_ sender: Any) {
        
        var url1 = NSURL(string: "tel://"+(mode?.reception_Phone!)!)
        UIApplication.shared.openURL(url1! as URL)
    }
    
    @IBAction func Navi(_ sender: Any) {
        
        
        
//        let vc = GPSNaviViewController()
//        vc.end_longtitude = CGFloat((mode?.detail_Position_X)!)
//        vc.end_latitude = CGFloat((mode?.detail_Position_Y)!)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var decorateLabel: UILabel!
    @IBOutlet weak var scollView: UIScrollView!
    
    var rooms:[Room] = [Room](){
        didSet{
            if rooms[0].pictures.count == 0 {
                
            }else{
                
              self.ImgeView.mode = rooms[0]
                
            }
            tableview.reloadData()
        }
    }
    var params:SearchParamModel?{
        didSet{
            recordOrder.booking_CheckIn_Date = params?.checkInDate
            recordOrder.booking_Leave_Date = params?.leaveDate
            
            recordOrder.user_Id = UserAccount.loadUserAccount()?.user_Id
           
            
            
        }
    }
    var ImgeView:HotelImageView! = HotelImageView.LoadFromNib()//HotelImageView()
    override func viewDidLoad() {
         manager.delegate = self
        super.viewDidLoad()
        self.scollView.contentSize = CGSize.init(width: KScreenW, height: 1200)
        setUpUI()
        NotificationCenter.default.addObserver(self, selector: #selector(dealResult), name: NSNotification.Name.init("paySuccess"), object: nil)
        
       
        loadDatas()
    }
    func loadDatas(){
       HotelViewModel.shareInstance.getHotelWithVC(VC: self)
    }
    //处理支付结果。
    @objc func dealResult(){
        SVProgressHUD.showSuccess(withStatus: "支付成功，请到我的订单界面查看详情")
 present(FWNavigationController.init(rootViewController: MyOrdersViewController()), animated: true, completion: nil)
    }
}
extension HotelViewController{
    func setUpUI(){
    
        self.navigationItem.title = "酒店详情"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "shareIcon"), style: .done, target: self, action: #selector(share))
        self.nameLabel.text = mode!.hotel_Name
        self.daysCountLabel.text = "共"+"\(NSDate.daysCalculate(params?.checkInDate, endDays: params?.leaveDate))"+"天"
        self.payView.frame = CGRect.init(x: 0, y: kScreenH-350, width: KScreenW, height: 285)
        self.payView.backgroundColor = UIColor.white
        let url = URL(string:(mode?.pic)! )
      addLabel.text = mode?.hotel_Address
      priceView.frame = CGRect.init(x: 0, y: KScreenH-160+tabBarbottomHeight, width: KScreenW, height: 160+tabBarbottomHeight)
     //phoneButton.setTitle(mode?.reception_Phone, for: .normal)
        
        var timeStr = "入住时间: " + String.chanageDateString(str: (params?.checkInDate)!) + "-" + String.chanageDateString(str: (params?.leaveDate)!)
        let  timeStr1:String = String.chanageDateString(str: (params?.leaveDate)!)
        
        
        timeLabel.text = "入住时间: " + String.chanageDateString(str: (params?.checkInDate)!) + "-" + String.chanageDateString(str: (params?.leaveDate)!)
        
        iconImageView.kf.setImage(with: url)
      //self.view .addSubview(priceView)
        self.distanceBtn.setTitle(mode?.distanceText, for: .normal)
      self.view.insertSubview(self.priceView, at: 0)
      tableview.register(UINib.init(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: RoomID)
      
      tableview.rowHeight = 190
      tableview.tableFooterView = UIView()
    }
    @objc func share(){
        let pop = ZXPopView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: KScreenH))
        let shareView = ShareView.init(frame: CGRect.init(x: 0, y: KScreenH, width: KScreenW, height: 200))
        shareView.callBack = { type in
            //
            self.shareWithType(type: type)
        }
        
        pop.contenView = shareView
        pop.showInWindow()
        
        
    }
    
    func shareWithType(type:NSInteger){
        
        switch type {
        case 0:
            shareViewMode.sharedInstance.sence = WXSceneSession
            shareViewMode.sharedInstance.url = "http://www.iyouker.com/Maxwell/v2/share/go/hotelInfo/" + "\(self.mode!.hotel_Id)"
            shareViewMode.sharedInstance.title = self.mode?.hotel_Name
            shareViewMode.sharedInstance.desc = "我在这里订房啦"
            shareViewMode.sharedInstance.shareHotel()
            break
        case 1:
            shareViewMode.sharedInstance.sence = WXSceneTimeline
            shareViewMode.sharedInstance.shareHotel()
            break
        default:
            SVProgressHUD.show(withStatus: "此功能正在开发中")
            break
        }
    }
}
 extension HotelViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomID) as! RoomTableViewCell
        if cell == nil {
            cell  == RoomTableViewCell()
        }
        cell.price = (self.params?.price)!
        cell.room = rooms[indexPath.row]
        cell.callBack = { room in
        print("__^^^^^^^^^^^^^^^^^^^")
         let vc   =  PlaceOrderViewController()
         vc.mode = room
         vc.params = self.params
         vc.priceToken = self.priceToken
         vc.recordOrder = self.recordOrder
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        

        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.rooms.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let room = self.rooms[indexPath.row]
       let vc = RoomViewController()
        vc.room = room
        vc.introduce = self.mode?.hotel_Introduce
        vc.recordOrder = self.recordOrder
        vc.searchParam = self.params
        vc.priceToken = self.priceToken
   navigationController?.pushViewController(vc, animated: true)
        

    }
    
   
}
extension HotelViewController:WXApiManagerDelegate{
    
}
 
 
 
