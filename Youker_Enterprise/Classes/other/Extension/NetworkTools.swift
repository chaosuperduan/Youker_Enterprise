//
//  NetworkTools.swift
//  Alamofire的测试
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : [String:AnyObject]?,_ errorMsg:String?) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
       // let a = parameters!
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print("-----")
                
                print(response.result.error ?? "")
                print("-----")
                finishedCallback(nil,"网络连接失败")
                return
            }
            //处理Unicode编码。将unicode编码的json转成uft8编码
            guard  let data = response.data  else{
                return
            }
            let utf8Text = String(data: data , encoding: .utf8)
            print(utf8Text ?? "编码错误")
            
            guard  let respObj :[String:AnyObject] = result as? [String : AnyObject] else{
                return
            }
            print(respObj)
            
            let code:Int = respObj["code"] as! Int
            if code == 200 {
                
                finishedCallback(respObj,nil)
            }else{
                if(code == 405){
                   
                    let params = NSMutableDictionary()
                    params["userNum"] = UserAccount.loadUserAccount()?.phone_Number
                    params["pwd"] = UserAccount.loadUserAccount()?.user_Pwd
                    params["registerId"] = UserAccount.loadUserAccount()?.registration_ID
                    LoginViewModel.sharedInstance.Login(params: params as! [String : AnyObject], orVC: nil, caBalck: nil)
                    
                }else{
                    
                    if( respObj.keys.contains("message")){
                        
                        finishedCallback(nil, respObj["message"] as! String)
                        
                    }
                }
                
                
               
               
                
            }
            // 4.将结果回调出去
        }
    }
    
    //不处理结果的请求
    class func requestDataNOCheck(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : [String:AnyObject]?,_ errorMsg:String?) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        // let a = parameters!
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print("-----")
                
                print(response.result.error ?? "")
                print("-----")
                finishedCallback(nil,"网络连接失败")
                return
            }
            //处理Unicode编码。将unicode编码的json转成uft8编码
            guard  let data = response.data  else{
                return
            }
            let utf8Text = String(data: data , encoding: .utf8)
            print(utf8Text ?? "编码错误")
            
            guard  let respObj :[String:AnyObject] = result as? [String : AnyObject] else{
                return
            }
            print(respObj)
            finishedCallback(respObj, "成功")
            
//            let code:Int = respObj["code"] as! Int
//            if code == 200 {
//                finishedCallback(respObj,nil)
//            }else{
//                finishedCallback(nil, respObj["message"] as! String)
//            }
            // 4.将结果回调出去
        }
    }
    
    
    //上传图片；
    class func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["userInfo"]
                
                
                //let userId = params["userId"]
                //multipartFormData.append(flag?.data(using: String.Encoding.utf8), withName: ""),
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "userInfo")
                //                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                
                
                for i in 0..<data.count {
                    
                    let baseData = data[i].base64EncodedString()
                    print(baseData)
                    
                    
                    
                   // let str = String.init(data: baseData, encoding: String.Encoding.utf8)
                    
                    
                   // multipartFormData.append(baseData, withName: "picture", fileName: name[i], mimeType: "image/png")
                    //multipartFormData.a
                    //multipartFormData.append(baseData, withName: "picture", mimeType: "image/png")
                }
        },
            to: urlString,
            method: .post,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            
                            print(value)
                        }
                        
                        print("响应请求:"+"\response.response?.statusCode")
                        guard  let data = response.data  else{
                            return
                        }
                       let utf8Text = String(data: data , encoding: .utf8)
                        print("照片上传返回:"+utf8Text!)
                    }
                case .failure(let encodingError):
                    print(encodingError);
                    
                    failture(encodingError)
                }
        }
        )
    }
    
    //静默登录。
    
    func QuickLogin(){
        let params = NSMutableDictionary()
        params["userNum"] = UserAccount.loadUserAccount()?.phone_Number
        params["pwd"] = UserAccount.loadUserAccount()?.user_Pwd
        params["registerId"] = UserAccount.loadUserAccount()?.registration_ID
        LoginViewModel.sharedInstance.Login(params: params as! [String : AnyObject], orVC: nil, caBalck: nil)
        
    }
}
