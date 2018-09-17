//
//  AddViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//


///mark--添加企业员工控制器,添加管理控制器。
///_添加类型。
enum addType {
    case ADD_ADMIN,ADD_EMPLOYEE
}


import UIKit

class AddViewController:BaseViewController {
    var user:User?
    var type:addType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(submit))
        

       
    }
    @objc func  submit(){
        
        if self.type != nil {
            if self.type == addType.ADD_ADMIN {
                ///添加管理员
                addAdmin()
                
                
            }else{
                ///添加员工。
                addEmployee()
                
                
            }
            
        }
        
      
        
    }
    
    func addEmployee(){
        
        
        
    }
    
    func addAdmin(){
        let params = NSMutableDictionary()
        
        params["companyId"] = UserAccount.loadUserAccount()
        
        //被添加人姓名。
        
        params["userName"] = user?.employee_Name!
        params["phoneNumber"] = user?.phoneNumber
        params["operateUser"]  = UserAccount.loadUserAccount()?.user_Id
        
        
        
        GroupInfoViewModel.sharedInstance.ADDCompanyAdmin(params: params as! [String : AnyObject], orVC: self) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpui(){
        
        
        
    }
    

   

}
