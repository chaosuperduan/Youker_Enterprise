//
//  String+Extension.swift
//  ZXWeiBo
//
//  Created by 段振轩 on 2018/1/9.
//  Copyright © 2018年 段振轩. All rights reserved.
//

import Foundation
extension String{
    
   static  func dataTypeTurnJson(element:AnyObject) -> String {
        
        let jsonData = try! JSONSerialization.data(withJSONObject: element, options: JSONSerialization.WritingOptions.prettyPrinted)
        let str = String(data: jsonData, encoding: String.Encoding.utf8)!
//        //路径
//        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
//        let filePath = path.stringByAppendingString("/data666.json")
//        try! str.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
//        print(filePath) //取件地址 点击桌面->前往->输入地址跳转取件
        
        return str
    }
    
   
    
    func cachesDir() -> String {
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        // 2.生成缓存路径
        
        let name = (self  as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        
        return filePath
        
        
        
    }
    
    func temDir() -> String {
        
        
        
        // 1.获取缓存目录的路径
        let path = NSTemporaryDirectory()
        
        
        let name = (self as NSString).lastPathComponent
        // 2.生成缓存路径
        let filePath = (path as NSString).appendingPathComponent(name)
        
        
        return filePath
        
        
    }
    
    
    static func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    ///字符串转时间.
    static func chanageDateString(str:String)->String{

        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY-MM-dd"
        
        let newDate:NSDate =  formatter.date(from: str) as! NSDate
        return  newDate.string(withFormat: "MM-dd")
    }
    
}



