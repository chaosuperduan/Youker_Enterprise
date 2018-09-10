//
//  ManageEnterUserTableViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ManageEnterUserTableViewController: BaseTableViewController{
    
    
    var dataArray:[UserGroupModel] = [UserGroupModel]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpUI()
        

        
    }
    
    override func loadDatas() {
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        GroupInfoViewModel.sharedInstance.GetUserGroup(params: params as! [String : AnyObject], orVC: self) {
            SVProgressHUD.showSuccess(withStatus: "数据加载成功")
        }
        
        
        
    }

  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return self.dataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return (self.dataArray[section].users?.count)!
        
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "manageCell", for: indexPath) as! ManageUserCellTableViewCell
        
        if cell == nil  {
            cell = ManageUserCellTableViewCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func setUpUI(){
      self.navigationItem.title = "企业员工管理"
        self.tableView.register(ManageUserCellTableViewCell.self, forCellReuseIdentifier: "manageCell")
        
        
    }
}
