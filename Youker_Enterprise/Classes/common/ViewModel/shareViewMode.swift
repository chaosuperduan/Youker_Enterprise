//
//  shareViewMode.swift
//  youke
//
//  Created by keelon on 2018/7/12.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
//分享的ViewMode
class shareViewMode: NSObject {
    var sence:WXScene = WXSceneSession
    static let sharedInstance = shareViewMode()
    var title:String?
    var desc:String?
    var url:String?
    
    
    
    func share(){
                let params = NSMutableDictionary()
                params["userId"] = UserAccount.loadUserAccount()?.user_Id
                params["token"] = UserAccount.loadUserAccount()?.token!
        BlindViewModel.sharedInstance.GetShareURL(params: params as! [String : AnyObject]) { (response,msg) in
            guard let dic:[String:AnyObject] = response as! [String : AnyObject] else{
                return
            }
            guard let url:String = dic["data"] as! String else{
                return
            }
            
            self.getShare(url: url)
            
            
        }
    }
    func getShare(url:String){
        
        let message = WXMediaMessage()
        message.title = "优客未来酒店,注册送好礼，精彩连连"
        message.description = "注册就送优惠券，邀请送现金红包，优客未来酒店火爆，引领酒店共享新模式"
        message.setThumbImage(UIImage.init(named: "future"))
        let ext = WXWebpageObject()
        ext.webpageUrl = url
        message.mediaObject = ext
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(self.sence.rawValue)
        WXApi.send(req)
    }
    func shareHotel(){
        
        let message = WXMediaMessage()
        message.title = title
        message.description = desc
        message.setThumbImage(UIImage.init(named: "future"))
        let ext = WXWebpageObject()
        ext.webpageUrl = url
        message.mediaObject = ext
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(self.sence.rawValue)
        WXApi.send(req)
    }

}
