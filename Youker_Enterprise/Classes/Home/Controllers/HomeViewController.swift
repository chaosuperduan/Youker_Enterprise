//
//  HomeViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

//head_Url    String?    "http://thirdwx.qlogo.cn/mmopen/vi_32/f77qC1elcRmeIN54OQBXEJlXiaDMrnaBXYGibFSux8Cwxdzeu7dSsnd0icZIu6SWPjLgQIPIicP4gsANuVlQNNlu3w/132"    some

import UIKit
let homeH = 198+tabBarbottomHeight//44+10+10;
class HomeViewController: BaseViewController {
     var hotellist:[HotelModel] = [HotelModel]()
     var param :SearchParamModel = SearchParamModel()
    var startDate:NSDate?
    var endDate:NSDate?
    var location:CLLocation?
    
    @IBOutlet weak var thirdV: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    var poi:AMapPOI?
    lazy var locationManager = AMapLocationManager()
    var addressBlock:PassBak?
    var currentCity:String = "定位中"{
        didSet{
            
//            cityView?.CityButton.setTitle( currentCity, for: .normal)
        }
    }
    
    var footView:HomeFootView = {
        return HomeFootView.LoadView()
    }()
    var isLogin:Bool?{
        didSet{
            if isLogin == true {
                if(UserAccount.loadUserAccount()?.head_Url != nil){
                    
                    header?.ImageIcon.kf.setImage(with: URL.init(string: (UserAccount.loadUserAccount()?.head_Url)!))
                    header?.titleLabel.text = UserAccount.loadUserAccount()?.nick_Name
                }
                
            }else{
                
              // header?.ImageIcon.image = UIImage.init(named: "userIcon")
            }
        }
    }
    var header :UserHeaderView?
    //设置UI.
    func setUpUi(){
       self.header = UserHeaderView.LoadFromNib()
        header?.frame = view1.bounds
        print(header?.frame)
        header?.callback = {
            let navi = FWNavigationController.init(rootViewController: UserCenterTableViewController())
            self.present(navi, animated: true, completion: nil)
            
        }
        
       let secView = HomeHeaderView.init(frame: CGRect.init(x: 0, y:0, width: KScreenW, height: 164))
        secView.callback = { index in
            self.doWithIndex(index: index)
        }
      print(secView.frame)
        view1.addSubview(header!)
      view2.addSubview(secView)
       setUpUifootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let acc = UserAccount.loadUserAccount()
        configLocationManager()
        self.isLogin = UserAccount.loadUserAccount()?.token != nil ? true: false
        
         setUpUi()
        param.leaveDate = Date.getTomorrowTime()
        param.checkInDate = Date.getCurrentTime()
        self.isLogin = UserAccount.loadUserAccount()?.token != nil ? true: false
        locationManager.startUpdatingLocation()
       
      }
    
    func configLocationManager() {
        locationManager.delegate = self
        locationManager.locatingWithReGeocode = true
        locationManager.reGeocodeTimeout = 6
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
    }

     //菜单的点击事件。
    func doWithIndex(index:NSInteger){
        switch index {
        case 0:
            let naVi = FWNavigationController.init(rootViewController: ManagementViewController())
            present(naVi, animated: true, completion: nil)
            
        
            break
        case 1:
            let naVi = FWNavigationController.init(rootViewController: MyOrdersViewController())
            present(naVi, animated: true, completion: nil)
            
            
            break
        case 3:
            let naVi = FWNavigationController.init(rootViewController: StaffAddTableViewController())
            present(naVi, animated: true, completion: nil)
            break
        case 4:
            let naVi = FWNavigationController.init(rootViewController:  SystemableViewController())
            present(naVi, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
}

extension HomeViewController{
    func QuickLogin(account:UserAccount){
        let param = NSMutableDictionary()
        param["userNum"] = account.phone_Number
        param["pwd"] = account.user_Pwd
        account.savaAccout()
        if account.registration_ID == nil {
            let str:String = UserDefaults.standard.value(forKey: "registration_ID") as! String
            if(str == nil){
                SVProgressHUD.showError(withStatus: "获取registerID失败")
                return
            }else{
                param["registerId"] = str
            }
        }else{
            param["registerId"] = account.registration_ID
        }
        LoginViewModel.sharedInstance.Login(params: param as! [String : AnyObject], orVC: nil, caBalck: { (str) in
            self.isLogin = true
            SVProgressHUD.showSuccess(withStatus: str)
        })
    }
    //MARK:-设置的尾部。
    func setUpUifootView(){
        footView.frame = thirdV.bounds
        footView.submit = { str in
            let price:Double = Double(str) ?? 0
            self.param.price = NSInteger(price)
        }
        print("+++++66&"+"\(footView.frame)")
        print(footView.frame)
        footView.callBak = {
            
            SearchHotelViewModel.sharedInstance.getHotel(params: nil, origionVc: self)
        }
        footView.operationBlock = {(methodType,str,closureblock)
            in
            self.addressBlock = closureblock
            switch methodType {
            case .address:do {
                let vc = AddressViewController()
                vc.currentCity = self.currentCity
                vc.location = self.location
                vc.callBack = { poi
                    in
                    self.poi = poi
                    self.addressBlock!(poi.name)
                    
                    self.param.detailPositionX = Double(poi.location.longitude)
                    self.param.detailPositionY = Double(poi.location.latitude)
                    let annotation = POIAnnotation.init(poi: poi)

                }
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.frame.origin.y = self.view.frame.origin.y - 300
                    self.present(vc, animated: true, completion: nil)
                })
            }
                break
           
            case .startTime:do{
                
                let picker = WSDatePickerView.init(dateStyle: DateStyleShowMonthDay, complete: { (selectedDate) in
                    let data :NSDate = selectedDate as! NSDate
                    let str:String = data.string(withFormat: "yyyy-MM-dd")
                    let str1:String = data.string(withFormat:"MM-dd" )
                    
                    print(str)
                    self.param.checkInDate = str
                    if(data.isToday()){
                        //                       SVProgressHUD.showError(withStatus: "你选择的时间是昨天或者更早")
                        //                        return
                        self.startDate = data
                        self.addressBlock!(str1)
                        return
                    }else{
                        if(data.isInPast()){
                            SVProgressHUD.showError(withStatus: "你选择的时间早于今天")
                            return
                        }
                        self.startDate = data
                        self.addressBlock!(str1)
                        return
                    }
                })
                picker?.show()
            }
                break
            case .endTime:do{
             
                let picker = WSDatePickerView.init(dateStyle: DateStyleShowMonthDay, complete: { (selectedDate) in
                    let data :NSDate = selectedDate as! NSDate
                    let str:String = data.string(withFormat: "yyyy-MM-dd")
                    let str1:String = data.string(withFormat: "MM-dd")
                    print(str)
                    self.param.leaveDate = str
                    if self.startDate == nil {
                        SVProgressHUD.showError(withStatus: "请先选择入住时间")
                        return
                    }
                    if (data.isEarlierThanDate(self.startDate as! Date)){
                        SVProgressHUD.showError(withStatus: "你选择离开时间早于入住时间")
                        return
                    }
                    self.addressBlock!(str1)
                    let DIC =  SearchParamModel.getDict(mode: self.param)
                })
                picker?.show()
            }
                break
            default: break
            }
        }
       // self.KeyWordview = footView
       // self.view.addSubview(footView)
        thirdV.addSubview(footView)
    }
}
extension HomeViewController:AMapLocationManagerDelegate{
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        if isLogin == true{
            let acc = UserAccount.loadUserAccount()
            acc?.latitude = "\(location.coordinate.latitude)"
            acc?.longtitude = "\(location.coordinate.longitude)"
            acc?.savaAccout()
        }
        self.param.detailPositionX = location.coordinate.longitude
        self.param.detailPositionY = location.coordinate.latitude
        if reGeocode != nil {
            self.footView.addressBtn.setTitle(reGeocode.poiName, for: .normal)
            
            guard let cityStr :String = reGeocode.city else{
                return
            }
            self.currentCity = reGeocode.city
            self.locationManager.stopUpdatingLocation()
        }
        self.locationManager.requestLocation(withReGeocode: true) { (location, reggeocode, error) in
            print(error?.localizedDescription)
            print(reGeocode.aoiName)
            print(reGeocode.city)
        }
        self.location = location
    }
}

