//
//  AppDelegate.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

let APIKey = "893e092264f077e401061442d2339eb2";
let jipushKey = "8ac6d7e408e6241c05570cd2"
let WXkey = ""
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
       let vc = HomeViewController()
        if UserAccount.loadUserAccount()?.token !=  nil{
           let vc = HomeViewController()
        self.window?.rootViewController = vc


        }else{

           let vc = FirstViewController()

            self.window?.rootViewController = vc
        }
         //self.window?.rootViewController = vc
        self.window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
         AMapServices.shared().apiKey = APIKey
    JPUSHService.register(forRemoteNotificationTypes: (UIUserNotificationType.badge.union(UIUserNotificationType.sound).union(UIUserNotificationType.alert)).rawValue, categories:nil)
        
        
        JPUSHService.setup(withOption: launchOptions, appKey:jipushKey, channel:"", apsForProduction:true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.self.networkDidLogin(notification:)), name: NSNotification.Name.jpfNetworkDidLogin, object: nil)
        
        //微信支付
        WXApi.registerApp("wx03e9d2bf62182d81", enableMTA: true)
        
        
        return true
    }
    
    
    
    //在这里拿到divieToken 向极光注册拿到registID;拿到registID后可能需要上传到您的应用服务器，
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("divceToken"+"\(deviceToken)");
        
        JPUSHService.registerDeviceToken(deviceToken)
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
   
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    @objc public func networkDidLogin(notification:NSNotification){
        
        if (JPUSHService.registrationID() != nil) {
            
            
            let str:String = JPUSHService.registrationID()
            print("registId:"+str);
            if UserAccount.isLogin() {
                
                let account = UserAccount.loadUserAccount()
                account?.registration_ID = str
                
                account?.savaAccout()
                
            }else{
                
                let account = UserAccount.init(dic: ["registration_ID":str as AnyObject])
                account.savaAccout()
                UserDefaults.standard.set(str, forKey: "registration_ID")
            }
            
            
            
            
            //            if (UserAccount.isLogin() && str != nil) {
            //
            //
            //                let  account:UserAccount =  UserAccount.loadUserAccount()!
            //
            //                account.registId = str
            //                 account.savaAccout()
            //              }
            
            
        }
    }


}



extension AppDelegate {
    
    class func resizableImage(imageName: String, edgeInsets: UIEdgeInsets) -> UIImage? {
        
        let image = UIImage(named: imageName)
        if image == nil {
            return nil
        }
        let imageW = image!.size.width
        let imageH = image!.size.height
        
        return image?.resizableImage(withCapInsets: UIEdgeInsetsMake(imageH * edgeInsets.top, imageW * edgeInsets.left, imageH * edgeInsets.bottom, imageW * edgeInsets.right), resizingMode: .stretch)
    }
    
    /// 将颜色转换为图片
    ///
    /// - Parameter color: 颜色
    /// - Retns: UIImage
    class func getImageWithColor(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

