//
//  ModifyPasswordViewController.swift
//  youke
//  Created by keelon on 2018/5/31.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class ModifyPasswordViewController: BaseViewController {

    @IBOutlet weak var oldPwTF: UITextField!
    @IBOutlet weak var newPwTF: UITextField!
   
    @IBOutlet weak var ReNewPwTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改密码"
        let item = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = item;
    }
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func submit(_ sender: Any) {
     print(oldPwTF.text)
     print(newPwTF.text)
     let password = UserAccount.loadUserAccount()?.user_Pwd
        if oldPwTF.text != password {
            SVProgressHUD.showError(withStatus: "请输入正确的原密码")
            return
        }
        if newPwTF.text != ReNewPwTF.text{
            SVProgressHUD.showError(withStatus: "你输入的密码不一致")
            return
        }
        let param = NSMutableDictionary()
        let account = UserAccount.loadUserAccount()
        param["token"] = account?.token
        param["role_Id"] = account?.role_Id
        param["user_Id"] = account?.user_Id
        param["user_Pwd"] = newPwTF.text
        let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param)
        let paramJson = NSMutableDictionary()
        print(jsonStr)
        paramJson["userInfo"] = jsonStr
        paramJson["token"] = account?.token
        //UpdateUserInfo.sharedInstance.Login(params: paramJson as! [String : AnyObject], orVC: self)
        UpdateUserInfo.sharedInstance.Login(params: paramJson as! [String : AnyObject], orVC: self) {
            self.back()
        }
    }
}
