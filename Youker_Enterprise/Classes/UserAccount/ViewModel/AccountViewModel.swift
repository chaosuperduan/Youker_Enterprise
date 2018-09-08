//
//  AccountViewModel.swift
//  YOUKER_MERCHANT
//
//  Created by keelon on 2018/8/6.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit



//id CertificateViewmode:


class CertificateMode:NSObject{
     static let sharedInstance = CertificateMode()
    func registMerchant(params:[String:AnyObject],orVC:UpdateInfoViewController?,callback1:@escaping (()->())){
        print(RegisterMerchant)
        
        
        NetworkTools.requestData(.post, URLString:  RegisterMerchant, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
//                orVC?.errorMessage = mes
//                orVC?.ReqType = RequestResultType.ERROR
                return
                
            }else{
                
//                orVC?.ReqType = RequestResultType.SUCCESS
                callback1()
                
            }
    }
    }
}
