//
//  common.swift
//  youke
//
//  Created by 振轩 on 2018/5/12.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

let bacgColor = UIColor.init(r: 239, g: 239, b: 241)
let naviColor = UIColor.init(r: 60, g: 184, b: 255)
let backColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
let appid = "wx03e9d2bf62182d81"
let appscret = "2c961d969969881c5047028a73ddc547"
import Foundation
import UIKit
let KScreenW = UIScreen.main.bounds.size.width;
let KScreenH = UIScreen.main.bounds.size.height;
let MainColor = UIColor.init(red: 31/255.0, green: 183/255.0, blue: 136/255.0, alpha: 1.0)
let isIphoneX = KScreenH == 812 ? true : false
let tabBarbottomHeight : CGFloat = isIphoneX ? 34 : 0
let IPXstatusHeight:CGFloat = isIphoneX ? 24:0
let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabbarH : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let BackColor = UIColor.init(red: 247/255.0, green: 249/255.0, blue: 250/255.0, alpha: 1.0)
typealias PassBak = (String) -> ()
typealias AnyBack = (([String:AnyObject])->())
typealias LoginBolock = (UserAccount)->()


//关于角色id


/*
 
 9 普通用户。
 69 子商家
 131企业用户
 36经销商
 130 企业员工
 126 企业管理员
 125 企业主管理员
 8个人商家
 6联合运营商
 110子经销商
 70客服。
 7企业。
 */
