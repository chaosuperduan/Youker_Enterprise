//
//  BaseViewController.swift
//  youke

//  Created by keelon on 2018/5/23.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
enum RequestResultType{
    case SUCCESS,NODATA,ERROR,NETBAD,LIMIT
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
            case .LIMIT?: do{
                
                showNoAuthority(title: "没有权限")
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
    
    //展示无权限的界面。
    func showNoAuthority(title:String){
        //删除员工。
        let popView = ZXPopView.init(frame: self.view.bounds)
        let actionView = ActionView.LoadFromNib()
        actionView.title = "暂无权限，请联系管理员"
        actionView.callBack = { isdone in
            if isdone {
              
                popView.dismissView()
            }else{
                
                popView.removeFromSuperview()
                
            }
            
        }
        
        actionView.frame = CGRect.init(x: (KScreenW-325)/2, y: (KScreenH-167)/2, width: 325, height: 167)
        popView.contenView = actionView
        popView.isCenter = true
        popView.showInView(view: self.view)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bacgColor;
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
