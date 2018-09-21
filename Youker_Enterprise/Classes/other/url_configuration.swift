//
//  url_configuration.swift
//  youke
//
//  Created by keelon on 2018/5/29.
//  Copyright © 2018年 M2Micro. All rights reserved.

//url配置。136 7397 6817

import Foundation
//103
let rootURL = "http://192.168.31.203:8080/Maxwell/"
let rootURL2 = "http://www.iyouker.com/Maxwell/"
//let rootURL = "http://jjfly.ngrok.iyouker.com:8080/Maxwell/"
//MARK:-登录
let LoginURL = rootURL+"v3/cpy/login"
//MARK:-注册
let registerURL = rootURL+"reg/regNewUser"
//MARK:-搜索附近的酒店
let searchHotelURL = rootURL+"v3/"+"booking/search/hotel"
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

//注册企业。

let RegisterMerchant = rootURL + "v3/cpy/add/cpyInfo"
//邀请用户。
let InviteURL = rootURL + "v3/cpy/invite/user"
//根据公司ID获取所有分组和与员工信息
let GetGroupInfoAndUser = rootURL+"v3/cpy/get/groups/users/cpyId"

//根据分组ID获取分组和用户信息
let GetGroupByID = rootURL+"v3/cpy/get/users/group"
//添加企业分组信息。
let addGroupInfo = rootURL + "v3/cpy/add/groupInfo"
//修改企业分组信息。
let UpdateGroupInfo = rootURL + "v3/cpy/add/groupInfo"
//获取企业分组信息。
let GetGroupInfo = rootURL + "v3/cpy/get/groupInfo/cpyId"
//删除企业分组信息。
let DeleteGroupInfo = "v3/cpy/del/groupInfo/groupId"
//添加企业管理员。
let AddEnterAdmURL = "v3/cpy/grant/user/purview"

//删除企业管理员。
let DeleteEnterAdmURL = rootURL + "v3/cpy/cancel/user/purview"
//批量添加员工到分组。
let AddUserToGropURL = rootURL +  "v3/cpy/add/users/group"
//批量添加员工到分组
let DeleteUserToGroupURL = "v3/cpy/del/users/group"
//获取企业管理员。
let GetAdminInfoURL = rootURL + "v3/cpy/get/admins/info"
//获取邀请url
let GetInviteURL = "v3/cpy/get/inviteUrl"
//根据员工状态获取员工列表
let GetUsersList = rootURL + "v3/cpy/get/user/state"
//删除企业员工信息。
let DeleteEmployeeURL = rootURL + "v3/cpy/del/user/userId"
