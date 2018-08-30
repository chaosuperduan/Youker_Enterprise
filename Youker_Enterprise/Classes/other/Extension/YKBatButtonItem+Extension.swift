//
//  YKBatButtonItem+Extension.swift
//  youke
//
//  Created by Duan Chao on 2018/5/15.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import Foundation
import UIKit
protocol NibLoad {
    
}
//where作用对谁遵守这个协议做一个限制。
extension NibLoad where Self : UIView
{
    //在协议和类中方法只能用static修饰，而不能用class修饰。
    static func LoadFromNib()->Self{
        
    
    return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
}


extension UIBarButtonItem{

    class func setUpBarButtonItemWithImage(imageName:String, target:AnyObject,action:Selector)->UIBarButtonItem {
      
      let imageView:UIImageView = UIImageView.init(frame: CGRect(x: 0, y: -10, width: 40, height: 40))
      imageView.layer.cornerRadius = 20
      imageView.layer.masksToBounds = true
       // imageView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        if UserAccount.isLogin() {
            if UserAccount.loadUserAccount()?.head_Url != nil {

                GA_ImageLoader.sharedLoader.imageForUrl(urlString: (UserAccount.loadUserAccount()?.head_Url)!) { (img, str) in
                   
                    let scalImge = img?.scaleToSize(img: img!, size: CGSize.init(width: 40, height: 40))
                    imageView.image = scalImge
                }
               
                
            }else{
                let image = UIImage.init(named: "user_icon")
                
                imageView.image = image?.scaleToSize(img: image!, size: CGSize.init(width: 40, height: 40))
            }
        }else{
            let image = UIImage.init(named: "user_icon")
            
            imageView.image = image?.scaleToSize(img: image!, size: CGSize.init(width: 40, height: 40))
            
        }
        
        
      
      //imageView.image = UIImage.init(named: imageName)
      //imageView.backgroundColor = UIColor.red
        //imageView.frame =
       // imageView.sizeToFit()
      //print(imageView.frame)
        
        
        let tapGR = UITapGestureRecognizer(target: target, action: action)
        imageView.addGestureRecognizer(tapGR)
        
        //////手势处理函数
        func tapHandler(sender:UITapGestureRecognizer) {
            
        }
        let item = UIBarButtonItem.init(customView: imageView)
        
        return item
        
    }
    class func createBarButtonItem(imageName:String, target:AnyObject, action:Selector) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
}
extension UIButton{
    
    convenience init(imageName : String,selectImage : String) {
        
        // 便利构造方法必须依赖于指定构造方法!!!!!!!!!!!!!!
        self.init()
        // 初始化按钮
        // 设置按钮图片
        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: selectImage), for: UIControlState.highlighted)
     }
    
}
