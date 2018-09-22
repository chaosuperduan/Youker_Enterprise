//
//  AddAdminTableViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class AddAdminTableViewController: BaseTableViewController {
    var DataMode:UserGroupModel?
    
    var admins:[User] = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        loadData()
    }
    
    
    
    func loadData(){
        let params = NSMutableDictionary()
        params["token"] = UserAccount.loadUserAccount()?.token!
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        params["userId"] = UserAccount.loadUserAccount()?.user_Id;
         AdminViewModel.sharedInstance.GetCompanyAdmin(params: params as! [String : AnyObject], orVC: self) {
            
        }
        
        
        
        
    }
    
    func setUpUi(){
        self.navigationItem.title = "添加管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "pl"), style: .plain, target: self, action: #selector(add))
        self.tableView.register(UINib.init(nibName: "ManageUserCellTableViewCell", bundle: nil), forCellReuseIdentifier: "add")
        self.tableView.tableFooterView = UIView()
    }
    @objc func add(){
        
        let vc  = AddViewController()
        vc.type  = addType.ADD_ADMIN
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return admins.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "add", for: indexPath) as! ManageUserCellTableViewCell
        
        if cell == nil  {
            
            cell = ManageUserCellTableViewCell()
            
            
        }
        cell.mode = self.admins[indexPath.row]
        cell.delete = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mode:User = self.admins[indexPath.row]
        
        deleteAdmin(user: mode)
        
    }
    
    //MARK:-删除管理
    func deleteAdmin(user:User){
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        params["userId"] = user.user_Id
        params["token"] = UserAccount.loadUserAccount()?.token
        params["operateUser"] = UserAccount.loadUserAccount()?.user_Id
        AdminViewModel.sharedInstance.DELETECompanyAdmin(params: params as! [String : AnyObject], orVC: self) {
           self.loadDatas()
        }
    }
}
