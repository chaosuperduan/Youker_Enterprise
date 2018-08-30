//
//  YoukerImageExtension.swift
//  youke
//
//  Created by keelon on 2018/5/24.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    func compressImage(image: UIImage, maxLength: Int) -> NSData? {
        let newSize = self.scaleImage(image: image, imageLength: 300)
        let newImage = self.resizeImage(image: image, newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = UIImageJPEGRepresentation(newImage, compress)
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(newImage, compress)
        }
        return data as! NSData
    }
    
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

import UIKit

class GA_ImageLoader {
    
    static let instance : GA_ImageLoader = GA_ImageLoader()
    
    class var sharedLoader : GA_ImageLoader {
        return instance
    }
    
    // 使用NSCache
    var cache = NSCache<AnyObject, AnyObject>()
    
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        // 异步获取图片
        DispatchQueue.global().async {
            // 从缓存中取
            let data: Data? = self.cache.object(forKey: urlString as AnyObject) as? Data
            // 缓存中存在直接去除并在主线程返回
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
            // 不存在去下载 使用 URLSession
            let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                if (error != nil) {
                    completionHandler(nil, urlString)
                    return
                }
                // 获得图片并且保存 主线程返回
                if data != nil {
                    let image = UIImage(data: data!)
                    self.cache.setObject(data as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                    return
                }
            })
            downloadTask.resume()
        }
    }
}




