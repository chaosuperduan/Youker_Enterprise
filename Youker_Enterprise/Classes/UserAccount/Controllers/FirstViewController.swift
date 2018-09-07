//
//  FirstViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var isLogin:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func registerEnterprise(_ sender: Any) {
        
//        present(RegisterViewController(), animated: true, completion: nil)
        
        let vc = RegisterViewController()
        vc.callBack = { account in
            print("AAA")
            
            self.QuickLogin(account: account)
        
            
        }
        present(FWNavigationController(rootViewController: vc), animated: true, completion: nil)
        
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
        let vc = LoginViewController()
        
        present(FWNavigationController(rootViewController: vc), animated: true, completion: nil)
        
    }
    

}
extension FirstViewController{
    func QuickLogin(account:UserAccount){
        let param = NSMutableDictionary()
        param["userNum"] = account.phone_Number
        param["pwd"] = account.user_Pwd
        account.savaAccout()
        
//        if account.registration_ID == nil {
//            let str:String = (UserDefaults.standard.value(forKey: "registration_ID") as? String)!
//            if(str == nil){
//                SVProgressHUD.showError(withStatus: "获取registerID失败")
//                return
//            }else{
//                param["registerId"] = str
//            }
//        }else{
//            param["registerId"] = account.registration_ID
//        }
        param["registerId"] = "paramfd"
        LoginViewModel.sharedInstance.Login(params: param as! [String : AnyObject], orVC: nil, caBalck: { (str) in
            self.isLogin = true
            SVProgressHUD.showSuccess(withStatus: str)
            
            self.present(FWNavigationController(rootViewController: UpdateInfoViewController()), animated: true, completion: nil)
            
            
        })
    }
    
    
}



