//
//  AddAcountViewController.swift
//  youke
//
//  Created by keelon on 2018/7/12.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class AddAcountViewController: BaseViewController {
    var isUpdate:Bool = false
    var addType:NSInteger = 0
    var unionId:String?
    var openid:String?
    var manger :WXApiManager = WXApiManager.shared()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var authorizeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        manger.delegate = self
        setUpui()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpui(){
        
        switch addType {
        case 85:
            do {
                if(isUpdate){
                   self.navigationItem.title = "更换微信提现账户"
                    
                }else{
                    
                    self.navigationItem.title = "添加微信提现账户"
                }
                    
            
            self.titleLabel.text = "请绑定本人微信账户"
            self.subTitleLabel.text = "微信账户"
             self.nameTF.placeholder = "微信账户"
            self.authorizeButton.isHidden = false
            }
            break
        case 84:
            do {
                self.navigationItem.title = "添加支付宝钱包"
                self.titleLabel.text = "请绑定本人支付宝账户"
                self.subTitleLabel.text = "支付宝账户"
                self.nameTF.placeholder = "支付宝账户"
            }
            break
        default:
            
            break
        }
        
    }
    @IBAction func addAccount(_ sender: Any) {
        if (nameTF.text?.count)!<2 {
            SVProgressHUD.showError(withStatus: "请输入或选择绑定账号")
            return
        }
        let params = NSMutableDictionary()
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        params["token"] = UserAccount.loadUserAccount()?.token!
        params["accountNumber"] = nameTF.text
//        if self.addType == 0 {
//            params["type"] = 85
//        }else{
//
//           params["type"] = 84
//        }
        if self.addType == 85 {
            params["unionId"] = self.unionId
            params["openid"] = self.openid
            
        }
        params["type"] = self.addType
        if (nameTF.text?.count)!<1 {
            SVProgressHUD.showError(withStatus: "请输入您的账户信息")
            
        }
        if isUpdate {
            BlindViewModel.sharedInstance.UpdateAccount(params: params as! [String : AnyObject], orVC: self)
        }else{
            BlindViewModel.sharedInstance.blindAccount(params: params as! [String : AnyObject], orVC:self)
            
        }
        
        
    }
    
    @IBAction func Authorize(_ sender: Any) {
        
        let req = SendAuthReq()
        //应用授权作用域，如获取用户个人信息则填写snsapi_userinfo
        req.scope = "snsapi_userinfo"
        WXApi.send(req)
    }
    func showSuccess(){
        SVProgressHUD.showSuccess(withStatus: "绑定成功")
        navigationController?.popViewController(animated: true)
        
    }
    
}


extension AddAcountViewController:WXApiManagerDelegate{
    
    func managerDidRecvAuthResponse(_ response: SendAuthResp!) {
        
        if response.errCode == 0 {
            print(response.code)
            print(response.country)
             weChatLogin.sharedInstance.weixinGetRefreshToken(code: response.code! as! String, caBalck: {str in
                
               self.nameTF.text =  weChatLogin.sharedInstance.nickname
               self.unionId = weChatLogin.sharedInstance.unionid
            
            })
        }else{
            
            SVProgressHUD.showError(withStatus: "微信授权登录失败")
        }
        
    }
}
