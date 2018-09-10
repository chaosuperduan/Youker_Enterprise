//
//  UserAccount.swift
//  ZXWeiBo
//
//  Created by 段振轩 on 2018/1/8.
//  Copyright © 2018年 段振轩. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    
    
   @objc var token:String?
   @objc var role_Id:NSNumber?
    
    @objc var company_Id:NSNumber?
    @objc var isvaild:NSNumber?
    
   @objc var nick_Name:String?
   @objc var user_Id:NSNumber?
   @objc var login_Type:NSNumber?
   @objc var age : NSNumber?
   @objc var phone_Number:String?
   @objc var user_Pwd:String?
   @objc var head_Url:String?
    @objc var longtitude:String?
    @objc var latitude:String?
    
    //微信头像
   @objc var headimgurl:String?
   

   @objc var registration_ID:String?

   @objc var registId:String?
   @objc var gender:String?//性别
    @objc var access_token:String?
    @objc var openid:String?
    
    
    //用户真实姓名
    @objc var user_Name:String?
    
    //用户身份证号码。
    @objc var card:String?
   ///  用户头像地址（大图），180×180像素
    var avatar_large: String?
    /// 用户昵称
    var screen_name: String?
    
    static var account:UserAccount?
    //存储位置的变量。
    static let filePath = "useraccount.plist".cachesDir()
    
    
    //生命周期的方法。
   init(dic:[String:AnyObject]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(head_Url, forKey: "head_Url")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(user_Id, forKey: "user_Id")
        aCoder.encode(phone_Number, forKey: "phone_Number")
        aCoder.encode(role_Id, forKey: "role_Id")
        aCoder.encode(login_Type, forKey: "login_Type")
        aCoder.encode(nick_Name, forKey: "nick_Name")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(user_Pwd, forKey: "user_Pwd")
        aCoder.encode(registration_ID, forKey: "registrationID")
        aCoder.encode(gender, forKey: "gender")
         aCoder.encode(headimgurl, forKey: "headimgurl")
         aCoder.encode(access_token, forKey: "access_token")
         aCoder.encode(openid, forKey: "openid")
        aCoder.encode(longtitude, forKey: "longtitude")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(card, forKey: "card")
        aCoder.encode(user_Name, forKey: "user_Name")
         aCoder.encode(company_Id, forKey: "company_Id")
         aCoder.encode(isvaild, forKey: "isvaild")
        
        

    }
    required init?(coder aDecoder: NSCoder) {
        self.head_Url = aDecoder.decodeObject(forKey: "head_Url") as? String
        self.token = aDecoder.decodeObject(forKey: "token") as? String
        
        self.user_Id = aDecoder.decodeObject(forKey: "user_Id") as? NSNumber
        self.phone_Number = aDecoder.decodeObject(forKey: "phone_Number") as? String
        self.login_Type = aDecoder.decodeObject(forKey: "login_Type") as? NSNumber
        
        self.nick_Name = aDecoder.decodeObject(forKey: "nick_Name") as? String
        self.avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        self.user_Pwd = aDecoder.decodeObject(forKey: "user_Pwd") as? String

         self.registration_ID = aDecoder.decodeObject(forKey: "registrationID") as? String
        self.gender = aDecoder.decodeObject(forKey: "gender") as? String
        self.headimgurl = aDecoder.decodeObject(forKey: "headimgurl") as? String
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.openid = aDecoder.decodeObject(forKey: "openid") as? String
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as? String
        self.longtitude = aDecoder.decodeObject(forKey: "longtitude") as? String
        self.card = aDecoder.decodeObject(forKey: "card") as? String
        self.user_Name = aDecoder.decodeObject(forKey: "user_Name") as? String
        self.company_Id = aDecoder.decodeObject(forKey: "company_Id") as? NSNumber
        
        self.isvaild = aDecoder.decodeObject(forKey: "isvaild") as? NSNumber
    }
    func savaAccout()->Bool{
    
        //生成缓存目录的路径。
       
        //归档对象
        
     print(UserAccount.filePath)
     return  NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
        
    }
    
    class func loadUserAccount()->UserAccount?{
        //判断是否加载过。
//        if UserAccount.account != nil{
//
//
//            return UserAccount.account
//
//            
//
//        }
        
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.filePath) as? UserAccount else
        {
            return UserAccount.account
        }
        UserAccount.account = account
        
        return UserAccount.account
    }
    
    class func isLogin()->Bool{
        return UserAccount.loadUserAccount()?.token != nil
        
    }
    func removeAll(){
        if(FileManager.default.fileExists(atPath: "useraccount.plist".cachesDir())){
            print("文件存在")
           try? FileManager.default.removeItem(atPath: "useraccount.plist".cachesDir())
            
        }else{
            
            
        }
    }

}

