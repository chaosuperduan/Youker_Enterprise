//
//  RegisterViewController.swift
//  youke
//17603014603
//  Created by 振轩 on 2018/5/12.
//  Copyright © 2018年 M2Micro. All rights reserved.
//注册一个企业版的测试账户。9977




import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var PhoneTF: UITextField!
    
    @IBOutlet weak var identyTF: UITextField!
    @IBOutlet weak var PwTF: UITextField!
    
    @IBOutlet weak var RePwTF: UITextField!
    
    @IBOutlet weak var RegistView: UIView!
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var registerBTN: UIButton!
    var callBack:LoginBolock?
    var loginBBK:PassBak?
    var identiCode:String  = "1"
    var isWeixinRegister:Bool=false
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            sendButton.setTitle("(\(newValue)秒后重新获取)", for: .normal)
            if newValue <= 0 {
                sendButton.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 5
                
                sendButton.backgroundColor = UIColor.gray
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                sendButton.backgroundColor = naviColor
            }
            
            sendButton.isEnabled = !newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.KeyWordview = self.view
        if isWeixinRegister {
           self.navigationItem.title = "完善登录信息"
        }else{
           self.navigationItem.title = "注册"
        }
        
    }

    @IBAction func Register(_ sender: Any) {
        
        
        print("----注册---")
        
        register()
        
    }
    
  @objc  func register(){
        
        
        down()
        
        self.RePwTF.resignFirstResponder()
        if PwTF.text != RePwTF.text{
            SVProgressHUD.showError(withStatus: "您输入的密码不一致")
        }
        let param = NSMutableDictionary()
        param["phone_Number"] = PhoneTF.text
        param["user_Pwd"] = PwTF.text
        //注册企业的，商户角色id是131
        param["role_Id"] = "131"
        param["login_Type"] = "72"
        
        if isWeixinRegister {
            param["access_token"] = UserAccount.loadUserAccount()?.access_token
            param["openid"] = UserAccount.loadUserAccount()?.openid
            // param["unique_id"] = UserAccount.loadUserAccount()?.openid
            param["type"] = 73
            param["login_Type"] = "73"
            param["registerId"] = "dfnkkkkk" //UserAccount.loadUserAccount()?.registration_ID
        }
        
        if self.identyTF.text != self.identiCode{
            SVProgressHUD.showError(withStatus: "请输入正确的验证码")
            return
        }
        if self.isWeixinRegister {
            let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param)
            let paramJson = NSMutableDictionary()
            paramJson["user"] = jsonStr
            
            
            weChatLogin.sharedInstance.LoginByWeixin(param: param as! [String : AnyObject], RegisterBack: {
                str in
                
                SVProgressHUD.showSuccess(withStatus: "微信登录成功!")
                self.dismiss(animated: true, completion: nil)
                
                
            })
            if(self.loginBBK != nil){
                self.loginBBK!("1")
                
            }
            
            self.dismiss(animated: true, completion:  nil)
            
            
        }else{
            
            let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param)
            let paramJson = NSMutableDictionary()
            paramJson["user"] = jsonStr
            
            RegisterViewModel.sharedInstance.register(params: paramJson as! [String : AnyObject], orVC: self) { (account) in
                let account1 = UserAccount.loadUserAccount()
                account.user_Pwd = param["user_Pwd"] as! String
                account.registId = account1?.registId
                if(self.isWeixinRegister){
                    NotificationCenter.default.post(name: NSNotification.Name.init("LoginBy"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                account.savaAccout()
               
                if(self.callBack != nil){
                     self.callBack!(account)
                     self.dismiss(animated: true, completion: nil)
                    
                    
                }
              }
        }
        
    }
    
    func getIdentyCode(){
        
        let param = NSMutableDictionary()
        param["phoneNumber"] = PhoneTF.text
        //param["user_Pwd"] = PwTF.text
        
        NetworkTools.requestData(.get, URLString: idCode, parameters: param as? [String : Any]) { (response, msg) in
            if(msg != nil){
                
                SVProgressHUD.showError(withStatus: msg)
                return
            }else{
                
                guard let codeStr :String = response?["data"] as! String else{
                    
                    return
                }
                
                self.identiCode = codeStr
                
            }
           }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        
    }
    
    @objc func sendButtonClick(_ sender: UIButton) {
        isCounting = true
        getIdentyCode()
        print("-----***_____")
    }
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
}
extension RegisterViewController{
    func setUpUI(){
        
        sendButton.addTarget(self, action: #selector(sendButtonClick(_:)), for: .touchUpInside)
        registerBTN.addTarget(self, action: #selector(register), for: .touchUpInside)
        let item = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = item;
    }
    
    @objc func back(){
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.PwTF.resignFirstResponder()
        self.identyTF.resignFirstResponder()
        self.PhoneTF.resignFirstResponder()
        self.RePwTF.resignFirstResponder()
        
       // present(UpdateInfoViewController(), animated: true, completion: nil)
    }
}
extension RegisterViewController:UITextFieldDelegate{
    
}
