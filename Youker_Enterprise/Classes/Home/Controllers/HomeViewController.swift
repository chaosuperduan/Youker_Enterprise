//
//  HomeViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
     var hotellist:[HotelModel] = [HotelModel]()
     var param :SearchParamModel = SearchParamModel()
    var isLogin:Bool?{
        didSet{
            
            
            
        
            
        }
        
    }
    //设置UI.
    func setUpUi(){
       let header = UserHeaderView.LoadFromNib()
        header.frame = CGRect.init(x: 0, y: 0, width: KScreenW, height: 260)
        print(header.frame)
        header.callback = {
            let navi = FWNavigationController.init(rootViewController: UserCenterTableViewController())
            self.present(navi, animated: true, completion: nil)
            
        }
       let secView = HomeHeaderView.init(frame: CGRect.init(x: 0, y: 270, width: KScreenW, height: 164))
        secView.callback = { index in
            self.doWithIndex(index: index)
        }
      print(secView.frame)
      view.addSubview(header)
      view.addSubview(secView)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLogin = UserAccount.loadUserAccount() != nil ? true: false
         setUpUi()
        
//        if self.isLogin == false {
//
//            let vc = RegisterViewController()
//            vc.callBack = { account in
//                self.QuickLogin(account: account)
//            }
//
//           // FWNavigationController(rootViewController: vc)
//            present(FWNavigationController(rootViewController: vc), animated: true, completion: nil)
//        }
       
        present(RegisterViewController(), animated: true, completion: nil)
        if UserAccount.loadUserAccount() != nil {
            let vc = RegisterViewController()
        
            present(vc, animated: true, completion: nil)
        }
       
        print("find")
        print(UserAccount.loadUserAccount()?.company_Id)
        print("findX")
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        present(RegisterViewController(), animated: true, completion: nil)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //菜单的点击事件。
    func doWithIndex(index:NSInteger){
        switch index {
        case 0:
            let naVi = FWNavigationController.init(rootViewController: ManagementViewController())
            present(naVi, animated: true, completion: nil)
            
        
            break
        case 3:
            let naVi = FWNavigationController.init(rootViewController: StaffAddTableViewController())
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
    
    
}


