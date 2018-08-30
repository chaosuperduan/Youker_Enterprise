//
//  TypeView.swift
//  SafeFoodManagerDemo
//
//  Created by 振轩 on 2018/4/28.
//  Copyright © 2018年 bob. All rights reserved.
//

import UIKit

class TypeView: UIView {

    var imagView:UIImageView?
    var label:UILabel?
    var text:String?{
        didSet{
            self.label?.text = text;
            
            
        }
    }
    var imageName:String?{
        didSet{
            self.imagView?.image = UIImage.init(named: imageName!)
            
        }
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        
        
        
    }
    
    func setUpUI(){
        let Imgframe:CGRect = CGRect.init(x: kScreenW/2-50, y: kScreenH/2-50, width: 100, height: 100)
        self.imagView = UIImageView.init(frame: Imgframe)
        let LabelFrame = CGRect.init(x: kScreenW/2-100, y: kScreenH/2-20+120, width: 200, height: 40)
        self.label = UILabel.init(frame: LabelFrame);
        self.label?.font = UIFont.systemFont(ofSize: 21)
        self.label?.textAlignment = .center
        self.addSubview(imagView!)
        addSubview(label!)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
