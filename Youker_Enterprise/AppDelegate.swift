//
//  AppDelegate.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
       let vc = HomeViewController()
        if UserAccount.loadUserAccount() !=  nil{
           let vc = HomeViewController()
        self.window?.rootViewController = vc


        }else{

           let vc = FirstViewController()

            self.window?.rootViewController = vc
        }
        self.window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        return true
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

