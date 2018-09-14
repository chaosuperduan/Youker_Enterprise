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
       self.header.beginRefreshing()
       self.tableView.tableFooterView = UIView()

        
    }
    
    override func loadDatas() {
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        params["token"] = UserAccount.loadUserAccount()?.token;
        GroupInfoViewModel.sharedInstance.GetUserGroup(params: params as! [String : AnyObject], orVC: self) {
            
            
            SVProgressHUD.showSuccess(withStatus: "数据加载成功")
            self.header.endRefreshing()
        }
        
        
       }

  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return self.dataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return (self.dataArray[section].users.count)
        
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "manageCell", for: indexPath) as! ManageUserCellTableViewCell
        
        if cell == nil  {
            cell = ManageUserCellTableViewCell()
        }
        let group:UserGroupModel = self.dataArray[indexPath.section]
        let mode :User = group.users[indexPath.row]
        
        
        //let mode = group[indexPath.row]
        cell.mode = mode
//        cell.mode = self.dataArray[indexPath.section].users[indexPath.row]
        cell.setupui()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 120, height: 20))
        
        
        label.text =  "  " + self.dataArray[section].group_Name!
        label.textColor = naviColor
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func setUpUI(){
      self.navigationItem.title = "企业员工管理"
        self.tableView.register(UINib.init(nibName: "ManageUserCellTableViewCell", bundle: nil), forCellReuseIdentifier: "manageCell")
        
        
    }
}
