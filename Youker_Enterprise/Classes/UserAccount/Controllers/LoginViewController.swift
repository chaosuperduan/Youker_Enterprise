//
//  LoginViewController.swift
//  youke
//
//  Created by Duan Chao on 2018/5/18.
//  Copyright © 2018年 M2Micro. All rights reserved.
//
import UIKit

class LoginViewController: BaseViewController{
    var manger :WXApiManager = WXApiManager.shared()

    @IBOutlet weak var PhoneTF: UITextField!
    
    @IBOutlet weak var pwTF: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        let param = NSMutableDictionary()
        param["userNum"] = PhoneTF.text
        param["pwd"] = pwTF.text
        let account = UserAccount.loadUserAccount()
        var registID = account?.registration_ID
        if registID == nil {
            registID = UserDefaults.standard.value(forKey: "registration_ID") as? String
        }
        
        if (PhoneTF.text?.count)! != 11 {
            SVProgressHUD.showError(withStatus: "请输入正确的手机号码")
            return
        }else if( (pwTF.text?.count)!<2){
            SVProgressHUD.showError(withStatus: "请输入密码")
            return
        }
        
        param["registerId"] = registID
        if registID == nil {
            if(PhoneTF.text == "18666208770"){
                 param["registerId"] = "171976fa8ad31d3c8ba"
                
            }
          
        }
        LoginViewModel.sharedInstance.Login(params: param as! [String : AnyObject], orVC: self, caBalck: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        let item = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back1))
        self.navigationItem.leftBarButtonItem  = item;
          NotificationCenter.default.addObserver(self, selector: #selector(loginSs), name: NSNotification.Name.init("LogSucc"), object: nil)
        manger.delegate = self
    }
    
    @objc func loginSs(){
    
        self.dismiss(animated: true, completion: nil)
    }
    @objc func back1(){
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func BackClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var dismiss: UIButton!
    var  callBack:(()->())?
    
    @IBOutlet weak var QQ: UIButton!
    
    
    @IBAction func QQLogin(_ sender: Any) {
        
        SVProgressHUD.showSuccess(withStatus: "此功能正在开发中,敬请期待！！")
    }
    
    @IBAction func WechatLogin(_ sender: Any) {
        
        let req = SendAuthReq()
        //应用授权作用域，如获取用户个人信息则填写snsapi_userinfo
        req.scope = "snsapi_userinfo"
        WXApi.send(req)
    }
    
    //忘记密码修改
    
    @IBOutlet weak var modifyPw: UIButton!
    
    @IBAction func modifyPwClick(_ sender: Any) {
           let navi = FWNavigationController.init(rootViewController: ModifyPasswordViewController())
        present(navi, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pwTF.resignFirstResponder()
        self.PhoneTF.resignFirstResponder()
        
    }
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = -200
        }
    }
    
}

extension LoginViewController:WXApiManagerDelegate{
    
    func managerDidRecvAuthResponse(_ response: SendAuthResp!) {
        
        if response.errCode == 0 {
            print(response.code)
            print(response.country)
            weChatLogin.sharedInstance.orVC = self
            weChatLogin.sharedInstance.weixinGetRefreshToken(code: response.code! as! String, caBalck: {str in
                self.callBack!()
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            
            SVProgressHUD.showError(withStatus: "微信授权登录失败")
        }
       
    }
}
