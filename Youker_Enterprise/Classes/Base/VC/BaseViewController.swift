//
//  BaseViewController.swift
//  youke

//  Created by keelon on 2018/5/23.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
enum RequestResultType{
    case SUCCESS,NODATA,ERROR,NETBAD
}
class BaseViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    //处理网络请求结果处理。
    var ReqType:RequestResultType?{
        didSet{
            switch ReqType {
            case .SUCCESS?:do {
                SVProgressHUD.showSuccess(withStatus: "数据加载成功")
            }
                break
            case .ERROR?: do{
                SVProgressHUD.showError(withStatus: self.errorMessage)
                }
                break
            case .NETBAD?: do{
                SVProgressHUD.showError(withStatus: "网络错误")
            }
                break
            default:
                break
            }
     }
    }
    var errorMessage:String?
    
    var KH:CGFloat = 0
    var KeyWordview: UIView?{
        didSet{
           KH = (KeyWordview?.frame.origin.y)!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        
        let name:String = note.name.rawValue
        print(name)
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        //获取键盘的size
        let kbRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
       if name == "UIKeyboardDidShowNotification" {
            //弹出键盘执行的方法。
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
        
            UIView.animate(withDuration: 0.5) {
                self.KeyWordview?.frame.origin.y = self.KH - deltaY
                
               }
        
            
        }else if (name == "UIKeyboardDidHideNotification"){
            //收起键盘的操作
            UIView.animate(withDuration: 0.5) {
            self.KeyWordview?.frame.origin.y = self.KH
            }
        }else{
            
        }
   }
    
    func down(){
        UIView.animate(withDuration: 0.5) {
            self.KeyWordview?.frame.origin.y = self.KH
            
        }
        
        
    }
  }
