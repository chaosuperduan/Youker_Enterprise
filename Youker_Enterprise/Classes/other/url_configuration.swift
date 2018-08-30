//
//  url_configuration.swift
//  youke
//
//  Created by keelon on 2018/5/29.
//  Copyright © 2018年 M2Micro. All rights reserved.

//url配置。136 7397 6817

import Foundation
//103
let rootURL2 = "http://192.168.31.203:8080/Maxwell/"
let rootURL = "http://www.iyouker.com/Maxwell/"

//MARK:-登录
let LoginURL = rootURL+"login/loginUser"
//MARK:-注册
let registerURL = rootURL+"reg/regNewUser"
//MARK:-搜索附近的酒店
let searchHotelURL = rootURL+"booking/search/hotel"
//MARK:-获取酒店详情
let HotelDetailURL = rootURL + "booking/search/room/factor"
//MARK:-获取订单。
let OREDR_URL = rootURL + "userInfo/get/orders/user"
///MARK:更改用户资料。
let OPDATEUSER_URL = rootURL + "userInfo/update/user"
///MARK:下单。
let SENDORDER_URL = rootURL + "booking/add/record"
//MARK:-获取手机验证码
let idCode=rootURL + "verify/sms/reg"
///身份证实名认证
let identityUrl = rootURL + "verification/idCard"
//MARK:-退款
let refuseOrder_URL = rootURL + "booking/search/room/refund"
//MARK:-登录

//第三方登录检查。
let Check_URL = rootURL + "login/checkUser/other"

//第三方登录。
let loginOther_URL = rootURL + "login/loginUser/other"
//booking - 获取确认接单的酒店
let confirmHotel_URL = rootURL+"booking/get/confirm/hotels"
//获取订单详情
let order_detail_URL = rootURL + "v2/booking/get/orderInfo/user"
//绑定的账户。
let BlindAccount = rootURL + "v2/userInfo/add/user/paymentAccount"
//更换绑定账户。
let UpdateAccounts = rootURL + "v2/userInfo/update/user/paymentAccounts"
//查询绑定账户。
let getAccount = rootURL + "v2/userInfo/get/user/paymentAccounts"
//查询奖励金。
let getBonus = rootURL + "v2/userInfo/get/bonus"

//提现奖励金
let extractBonus = rootURL + "v2/userInfo/extract/bonus"
//获取url
let getShareURL = rootURL + "v2/share/get/app/shareUrl"

//获取提现记录
let getWithdrawal = rootURL + "v2/userInfo/get/withdrawal/records"
//获取分享记录。
//删除订单。
let DeleteURL = rootURL + "v2/booking/delete/order/user"


