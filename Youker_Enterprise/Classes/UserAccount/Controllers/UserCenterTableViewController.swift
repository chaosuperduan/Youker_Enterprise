//
//  UserCenterTableViewController.swift
//  youke
//
//  Created by Duan Chao on 2018/5/14.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
let userID = "userID"
let userIcon = "userIcon"
let TitleArray = ["头像","昵称","性别","手机号码"]
class UserCenterTableViewController: BaseTableViewController {
    var gender :String = ""
    var nickName :String?
    var tf:UITextField?
   var  isEdit:Bool = false{
    didSet{
        
        
        if isEdit == false {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(submitCreate))
        }else{
            
             self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(submitCreate))
            
        }
        
    }
    
    }
    var accout = UserAccount.loadUserAccount()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "编辑资料"
        self.view.backgroundColor = UIColor.white
        self.isEdit = false
        setUpUi()
       
    }
    
    @objc func submitCreate(){
        self.isEdit = !self.isEdit
        if isEdit {
            let param = NSMutableDictionary()
            let account = UserAccount.loadUserAccount()
            param["token"] = account?.token
            param["role_Id"] = account?.role_Id
            param["user_Id"] = account?.user_Id
            param["nick_Name"] = self.nickName
           
            param["gender"] = self.gender
            let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param)
            let paramJson = NSMutableDictionary()
            print(jsonStr)
            paramJson["userInfo"] = jsonStr
            paramJson["token"] = account?.token
            UpdateUserInfo.sharedInstance.UpdateInfo(params: paramJson as! [String : AnyObject], orVC: self, callback1: {
                self.accout?.gender = self.gender
                self.tableView.reloadData()
            })
         
            
            
        }
    }
    func setUpUi(){
        navigationItem.title = "编辑资料"
        

        let item = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = item;
        tableView.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: userID)
        tableView.register(UINib.init(nibName: "UserImageViewCell", bundle: nil), forCellReuseIdentifier: userIcon)
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
    }
    @objc func back(){
        
       dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
          let cell = tableView.dequeueReusableCell(withIdentifier: userIcon, for: indexPath) as! UserImageViewCell
            if(UserAccount.isLogin()){
                
                if UserAccount.loadUserAccount()?.head_Url != nil {
                    GA_ImageLoader.sharedLoader.imageForUrl(urlString: (UserAccount.loadUserAccount()?.head_Url)!) { (img, str) in
                        
                        let scalImge = img?.scaleToSize(img: img!, size: CGSize.init(width: 44, height: 44))
                        cell.iconImageView.image = scalImge
                    }
                }else{
                    
                }
                
            }
            
            return cell
        }else{
            
           let cell = tableView.dequeueReusableCell(withIdentifier: userID, for: indexPath) as! UserTableViewCell
            cell.titleLabel.text = TitleArray[indexPath.row]
            switch indexPath.row{
            case 1:
                cell.SubtitleLabel.text = accout?.nick_Name
                cell.SubtitleLabel.isHidden = true
                cell.nameLabel.text =  accout?.nick_Name
                cell.nameLabel.isHidden = false
                self.tf =  cell.nameLabel
                cell.callbak = { (str,  back)in
                    
                   self.nickName = str
                }
                break
            case 2:
                //self.tf?.resignFirstResponder()
                //cell.nameLabel.resignFirstResponder()
                cell.SubtitleLabel.text = accout?.gender
                break
            case 3:
                cell.SubtitleLabel.text = accout?.phone_Number
                break
            
            default:
                break
            }
            return cell
        }
       
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            
            
            self.showCanEdit(true) { (image) in
                
              self.uploadImageWith(imge: image)
            }
            
            
            break
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: userID, for: indexPath) as! UserTableViewCell
            cell.nameLabel.isHidden = false
            break
        case 2:
            do {
                self.tf?.resignFirstResponder()
                let defaultSelValue = CGXPickerView.showStringPickerDataSourceStyle(CGXStringPickerViewStyle.styleGender)
                CGXPickerView.showStringPicker(withTitle: "性别", defaultSelValue: defaultSelValue, isAutoSelect: true, manager: nil, resultBlock: { (result, resultrow) in
                    self.gender = result as! String
                    let param = NSMutableDictionary()
                    let account = UserAccount.loadUserAccount()
                    param["token"] = account?.token
                    param["role_Id"] = account?.role_Id
                    param["user_Id"] = account?.user_Id
                    print(resultrow)
                    param["gender"] = result as! String;
                    let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param)
                    let paramJson = NSMutableDictionary()
                    print(jsonStr)
                    paramJson["userInfo"] = jsonStr
                    paramJson["token"] = account?.token!
                    UpdateUserInfo.sharedInstance.UpdateInfo(params: paramJson as! [String : AnyObject], orVC: self, callback1: {
                        self.accout?.gender = result as? String
                        self.accout?.nick_Name = self.nickName
                        self.accout?.savaAccout()
                        self.tableView.reloadData()
                    })
                   self.accout?.savaAccout()
                }, style: .styleGender)
            }
            break
            
        default:
            break
        }
    }
    
    //上传头像。
    func uploadImageWith(imge:UIImage?){
    
        
        let param = NSMutableDictionary()
        let account = UserAccount.loadUserAccount()
        param["token"] = account?.token
        param["role_Id"] = account?.role_Id
        param["user_Id"] = account?.user_Id
        //param["user_Name"] = "HONDA"
        let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param)
        let paramJson = NSMutableDictionary()
        print(jsonStr)
        paramJson["userInfo"] = jsonStr
        paramJson["token"] = account?.token
        print(jsonStr)
        
        
        guard let imageData = UIImagePNGRepresentation(imge!) else {
            return
        }
        let str = imageData.base64EncodedString()
        
        paramJson["picture"] = str
        
        
        UpdateUserInfo.sharedInstance.UpdateInfo(params: paramJson as! [String : AnyObject], orVC: self, callback1: {
            self.accout?.gender = self.gender
            self.tableView.reloadData()
        })
        NetworkTools.requestData(.post, URLString: OPDATEUSER_URL, parameters: paramJson as? [String : Any], finishedCallback: { (response, msg) in
            
        })

        
        
    }
    
    
    
    
    
    
    
    
    
    
}
