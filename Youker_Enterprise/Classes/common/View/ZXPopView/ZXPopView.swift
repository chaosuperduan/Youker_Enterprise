//
//  ZXPopView.swift
//  youke
//
//  Created by keelon on 2018/7/7.
//  Copyright © 2018年 M2Micro. All rights reserved.

// 自定义底部弹出视图。



import UIKit

class ZXPopView: UIView {
   
    var contenView:UIView?
    {
        didSet{
           setUpContent()
        }
    }
    var isCenter:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContent(){
        let button = UIButton.init(frame: self.bounds)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        self.addSubview(button)
        // self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        if self.contenView != nil {
            self.contenView?.y = self.height
            self.addSubview(self.contenView!)
        }
        self.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
        self.isUserInteractionEnabled = true
        //为view添加手势。
       
        
    }
    
    
    @objc func dismissView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (true) in
           self.removeFromSuperview()
           self.contenView?.removeFromSuperview()
        }
    }
    func showInView(view:UIView){
        if (view == nil && contenView == nil) {
            return
        }
        
        view.addSubview(self)
       UIView.animate(withDuration: 0.3, animations: {
             self.alpha = 1.0
        if(self.isCenter){
            self.contenView?.y = (self.height-(self.contenView?.height)!)/2
            
        }else{
            
           self.contenView?.y = self.height-(self.contenView?.height)!
        }
        
        }, completion: nil)
    }
    //在Window上展示，当我们有的界面可能不能获取某个view上的时候，可以Window上展示contentView
    func showInWindow(){
        
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
            self.contenView?.y = self.height-(self.contenView?.height)!
        }, completion: nil)
    }
}
