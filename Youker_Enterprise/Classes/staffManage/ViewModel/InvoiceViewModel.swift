//
//  InvoiceViewModel.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/10/7.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class InvoiceViewModel: NSObject {
    
       static let sharedInstance = InvoiceViewModel()
    
    
    //删除分组员工。
    
    func GetInvoice(params:[String:AnyObject],orVC:Order_DetailViewController?,callback1:@escaping (()->())){
        print(GetInvoiceURL)
        NetworkTools.requestData(.get, URLString:  GetInvoiceURL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            
            if(response != nil){
                
                guard let responseDic:[String:AnyObject] = response as! [String : AnyObject] else{
                    
                    
                    return
                }
                let code:NSInteger = responseDic["code"] as! NSInteger
                
                if(code == 200){
                    
                    orVC?.ReqType =  RequestResultType.SUCCESS
                    orVC?.doneInvoice()
                    callback1()
                }else{
                    
                    orVC?.ReqType  = RequestResultType.ERROR
                    orVC?.errorMessage = responseDic["message"] as! String
                    
                }
            }else{
                
                orVC?.ReqType  = RequestResultType.ERROR
                orVC?.errorMessage = mes
                
                
            }
        }
    }

    

}
