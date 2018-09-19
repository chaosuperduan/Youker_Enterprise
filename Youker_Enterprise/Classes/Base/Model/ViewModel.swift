//
//  ViewModel.swift
//  youke
//
//  Created by keelon on 2018/5/29.
//  Copyright © 2018年 M2Micro. All rights reserved.


/*
 
 public static final String LOvarDAO_NOMAL = "72";
 public static final String LOGINDAO_WX = "73";
 public static final String LOGINDAO_QQ = "74";
*/
//

import UIKit
///登录，
class LoginViewModel: NSObject {
   static let sharedInstance = LoginViewModel()
    var hotels_id:[String]? = [String]()
    var callBack:(()->())?
    func Login(params:[String:AnyObject],orVC:LoginViewController?,caBalck:PassBak?)  {
        print(LoginURL)
        NetworkTools.requestData(.post, URLString: LoginURL, parameters: params) { (response,mes) in
            print(response ?? "")
            
            if  response == nil{
                if (orVC != nil){
                    
                    orVC?.errorMessage = mes
                    orVC?.ReqType = RequestResultType.ERROR
                    return
                }else{
                    
                    caBalck!("登录失败")
                    return
                }
                
            }else{
                
                print(response)
                
                let dicts:[String:[String:AnyObject]] =  response!["data"]!  as! [String : [String : AnyObject]]
               
                let   dicAount:[String:AnyObject] = dicts["userInfo"]!
                
               
                
                
               
                
                if(orVC != nil ){
                    
                    orVC?.ReqType = RequestResultType.SUCCESS
                    
                    
                    let account = UserAccount.init(dic: dicAount )
                    account.user_Pwd = orVC?.pwTF.text
                   
                   
                    
                    
                    if(dicts.keys.contains("cpyInfo")){
                        
                        let copDic:[String:AnyObject] = dicts["cpyInfo"]!
                        
                        let copMode:cpyInfo = cpyInfo.init(dict: copDic)
                        print(copMode)
                        print(cpyInfo.getDic(mode: copMode))
                        
                         account.company_Id = copMode.company_Id
                        
                    }
                     account.savaAccout()
                    //orVC?.callBack1!()
                    caBalck!("登录成功.")
                    orVC?.dismiss(animated: true, completion: nil)
                    
                }else{
                    let account = UserAccount.init(dic: dicAount as! [String : AnyObject])
                    account.user_Pwd = UserAccount.account?.user_Pwd
                    
                    
                    if(dicts.keys.contains("cpyInfo")){
                        
                        let copDic:[String:AnyObject] = dicts["cpyInfo"]!
                        
                        let copMode:cpyInfo = cpyInfo.init(dict: copDic)
                        print(copMode)
                        print(cpyInfo.getDic(mode: copMode))
                        
                        account.company_Id = copMode.company_Id
                        
                    }
                    account.savaAccout()
                    
                    if(caBalck != nil){
                        caBalck!("登录成功")
                    }
                   
                    
                }
                return
            }
        }
    }
}

///


///MARK --注册
class RegisterViewModel: NSObject {
    
    static let sharedInstance = RegisterViewModel()
    
   
    var callBack:(()->())?
    func register(params:[String:AnyObject],orVC:RegisterViewController,callback:@escaping LoginBolock)  {
        print(registerURL)
        
        
        let urlconf = params.keys.contains("openid")
        let url = urlconf ? loginOther_URL:registerURL
        NetworkTools.requestData(.post, URLString: registerURL , parameters: params as? [String : Any]) { (response,mes) in
            print(response ?? "fff")
            if  response == nil{
                orVC.errorMessage = mes
                orVC.ReqType = RequestResultType.ERROR
                return
            }else{
                orVC.ReqType = RequestResultType.SUCCESS
                let account = UserAccount.init(dic: response!["data"] as! [String : AnyObject])
                callback(account)
                
                
            }
        }
    }
}


///修改密码。
class UpdateUserInfo: NSObject {
    static let sharedInstance = UpdateUserInfo()
    var callBack:(()->())?
    func Login(params:[String:AnyObject],orVC:ModifyPasswordViewController,callback1:@escaping (()->()))  {
        NetworkTools.requestData(.post, URLString:  OPDATEUSER_URL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                orVC.errorMessage = mes
                orVC.ReqType = RequestResultType.ERROR
                return
            }else{
                
                orVC.ReqType = RequestResultType.SUCCESS
                callback1()
            }
        }
    }
    
    func UpdateInfo(params:[String:AnyObject],orVC:BaseTableViewController?,callback1:@escaping (()->()))  {
        NetworkTools.requestData(.post, URLString:  OPDATEUSER_URL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                orVC?.errorMessage = mes
                orVC?.ReqType = RequestResultType.ERROR
                return
            }else{
                orVC?.ReqType = RequestResultType.SUCCESS
                callback1()
                
            }
        }
    }
}






///搜索附近的酒店
class SearchHotelViewModel: NSObject {
    static let sharedInstance = SearchHotelViewModel()
    var hotelIDS : [String] = [String]()
    func getHotel(params:[String:AnyObject]?,origionVc:HomeViewController){
        let param1 = NSMutableDictionary()
        let account = UserAccount.loadUserAccount()
//        let registID = UserDefaults.standard.value(forKey: "registration_ID")
//        if registID == nil {
//            SVProgressHUD.showError(withStatus: "获取registID失败")
//            return
//        }
//        SVProgressHUD.show(withStatus: "正在为您搜索酒店")
//        param1["registration_ID"] = registID
      
        param1["token"] = account?.token!
        param1["role_Id"] = account?.role_Id
        param1["user_Id"] = account?.user_Id
        let jsonStr:String = String.getJSONStringFromDictionary(dictionary: param1)
        let jsonRoom = String.getJSONStringFromDictionary(dictionary:SearchParamModel.getDict(mode: origionVc.param))
        print(jsonStr)
        print(jsonRoom)
        let token:String = (account?.token)!
        let jsparam = ["user":jsonStr,"factor":jsonRoom,"token":token] as [String : Any]
        
        print(jsparam)
        NetworkTools.requestData(.post, URLString: searchHotelURL, parameters: jsparam as? [String : Any]) { (response,mes) in
            SVProgressHUD.dismiss()
            print(searchHotelURL)
            print(response)
            if  response == nil{
                origionVc.errorMessage = mes
                origionVc.ReqType = RequestResultType.ERROR
                return
            }else{
                if(response != nil){
                    let str:String = response!["data"] as! String
                    let vc  = HotelListTableViewController()
                    vc.hotellist = origionVc.hotellist
                    origionVc.hotellist.removeAll()
                    vc.priceToken = str
                    vc.params = origionVc.param
            origionVc.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }}
    /// --MARK-- 获取确认酒店
    func getConfirmHotel(origionVc:HotelListTableViewController){
        let params = NSMutableDictionary()
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        params["token"] = UserAccount.loadUserAccount()?.token
        NetworkTools.requestData(.post, URLString: confirmHotel_URL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                origionVc.errorMessage = mes
                origionVc.ReqType = RequestResultType.ERROR
                return
            }else{
                if(response != nil){
                    guard let dic2:[[String:AnyObject]] = response!["data"] as? [[String:AnyObject]] else{
                      origionVc.ReqType = RequestResultType.NODATA
                        return
                        
                    }
                    for dic in dic2 {
                                let mode:HotelModel = HotelModel(dict: dic as! [String : NSObject])
                        let str:String = "\(mode.hotel_Id)"
                        self.hotelIDS.append(str)
                        origionVc.hotellist.append(mode)
                            }
                    origionVc.isMore = true
//                    let vc  = HotelListTableViewController()
//                    vc.hotellist = origionVc.hotellist
//                    origionVc.hotellist.removeAll()
//
//                    //vc.params = origionVc.param
//              origionVc.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
        
        
    }
    
    func getMoreConfirmHotel(origionVc:HotelListTableViewController){
        let params = NSMutableDictionary()
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        params["token"] = UserAccount.loadUserAccount()?.token
        params["hotelIds"] = String.dataTypeTurnJson(element: self.hotelIDS as AnyObject)
        NetworkTools.requestData(.post, URLString: confirmHotel_URL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                origionVc.errorMessage = mes
                origionVc.ReqType = RequestResultType.ERROR
                return
            }else{
                if(response != nil){
                    guard let dic2:[[String:AnyObject]] = response!["data"] as? [[String:AnyObject]] else{
                        if(origionVc.isMore){
                            origionVc.tableView.mj_footer.endRefreshingWithNoMoreData()
                           return
                        }else{
                            origionVc.ReqType = RequestResultType.NODATA
                            return
                        }
                       
                        
                    }
                   
                    for dic in dic2 {
                        let mode:HotelModel = HotelModel(dict: dic as! [String : NSObject])
                        let str:String = "\(mode.hotel_Id)"
                        self.hotelIDS.append(str)
                        origionVc.hotellist.append(mode)
                    }
                    origionVc.tableView.mj_footer.endRefreshing()
                    
                }
            }
        }
        
        
    }
    
    
}




class weChatLogin:NSObject{
    
     static let sharedInstance = weChatLogin()
    var access_token:String?
    var nickname:String?
    var headimgurl:String?
    var unionid:String?
    var openid:String?
    var orVC:LoginViewController?
    var callBack:PassBak?
    
    func weixinGetRefreshToken(code:String,caBalck:PassBak?){
       // "secret":"wx03e9d2bf62182d81"
        let param = ["appid":appid,"secret":appscret, "code":code,"grant_type":"authorization_code"]
        let url  =  NSString.init(format: "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", appid,appscret,code)
        print(url)
        self.callBack = caBalck
        NetworkTools.requestDataNOCheck(.get, URLString: url as String, parameters:nil) { (response, mess) in
            print(response)
            self.access_token = response?["access_token"] as! String
            self.unionid = response!["unionid"] as! String
            self.openid = response?["openid"] as? String
            let acc = UserAccount.loadUserAccount()
            acc?.access_token = self.access_token
            acc?.openid = self.openid
            acc?.savaAccout()
             self.getWechatInfo()
           
            
            }
    }
    //获取用户的资料。
    func getWechatInfo(){
        let url  =  NSString.init(format: "https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", access_token!,openid!)
        print(url)
        NetworkTools.requestDataNOCheck(.get, URLString: url as String, parameters:nil) { (response, mess) in
            print(response ?? "第三方登录失败")
            self.headimgurl = response?["headimgurl"] as? String
            self.nickname = response?["nickname"] as! String
            let params = NSMutableDictionary()
            let acc = UserAccount.loadUserAccount()
            acc?.headimgurl = self.headimgurl
            params["openId"] = response?["openid"]
            params["registerId"] = UserAccount.loadUserAccount()?.registration_ID
            
            if(self.orVC == nil){
                
                self.callBack!("成功")
                
            }else{
                self.LoginByCheck()
                
            }
            
            
            //self.LoginByCheck()
            
         }
    }
    
    //注册。
    func LoginByWeixin(param:[String:AnyObject],RegisterBack:PassBak?){
        print(loginOther_URL)
        NetworkTools.requestData(.post, URLString: loginOther_URL, parameters: param) { (response,mes) in
            if(response == nil){
                
                
            }else{
                let account = UserAccount.init(dic: response!["data"] as! [String : AnyObject])
                account.user_Pwd = UserAccount.account?.user_Pwd
                account.savaAccout()
               NotificationCenter.default.post(name: NSNotification.Name.init("LoginBy"), object: nil)
                
                
            }
          
        }
    }
    
    //检查用户是否存在。
    //注册。
    func LoginByCheck(){
        print(Check_URL)

        let params = NSMutableDictionary()
        params["access_token"] = self.access_token
        params["openid"] = self.openid
        NetworkTools.requestData(.post, URLString: Check_URL, parameters: params as! [String : Any]) { (response,mes) in
            print(response ?? "")
            
            
            if response  == nil{
                
                

                
            }else{
                let data:String  = response!["data"] as! String
                if(data == "200"){
                    if(self.orVC != nil ){
                        
                        let params =    NSMutableDictionary()
                        params["openId"] = self.openid
                        params["registerId"] = UserAccount.loadUserAccount()?.registration_ID
                        
                        LoginViewModel.sharedInstance.Login(params: params as! [String : AnyObject], orVC: self.orVC, caBalck: { (str) in
                            self.orVC?.dismiss(animated: true, completion: nil)
                        })
                        
                    }else{
                        self.callBack!("登录成功")
                    }
                    return
                    
                }else{
                    
                    let vc  = RegisterViewController()

                    
                    vc.isWeixinRegister = true
                    let navi = FWNavigationController.init(rootViewController: vc)
                    self.orVC?.present(navi, animated: true, completion: nil)
                    
                    
                }
                
            }
        }
    }
    
    

        
 func WechatLogin(orVC:LoginViewController?,caBalck:PassBak?)  {
            print(LoginURL)
    let params =    NSMutableDictionary()
    params["openId"] = self.openid
    params["registerId"] = UserAccount.loadUserAccount()?.registration_ID
    NetworkTools.requestData(.post, URLString: LoginURL, parameters: params as! [String : Any]) { (response,mes) in
                print(response ?? "")
                if  response == nil{
                    if (orVC != nil){
                        
                        orVC?.errorMessage = mes
                        orVC?.ReqType = RequestResultType.ERROR
                        return
                    }else{
                        
                        caBalck!("登录失败")
                        return
                    }
                    
                }else{
                    
                    if(orVC != nil ){
                        
                        orVC?.ReqType = RequestResultType.SUCCESS
                        let account = UserAccount.init(dic: response!["data"] as! [String : AnyObject])
                        account.user_Pwd = orVC?.pwTF.text
                        account.savaAccout()
                        orVC?.callBack!()
                        
                        orVC?.dismiss(animated: true, completion: nil)
                        
                    }else{
                        
                        let account = UserAccount.init(dic: response!["data"] as! [String : AnyObject])
                        account.user_Pwd = UserAccount.account?.user_Pwd
                        account.savaAccout()
                        caBalck!("登录成功")
                         NotificationCenter.default.post(name: NSNotification.Name.init("LogSucc"), object: nil)
                    }
                    return
                }
            }
        }
}


