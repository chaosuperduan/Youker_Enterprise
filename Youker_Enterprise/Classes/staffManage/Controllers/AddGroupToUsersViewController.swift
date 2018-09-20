//
//  AddGroupToUsersViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/20.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class AddGroupToUsersViewController: UIViewController {
    
    
    var mode:UserGroupModel?
    
    @IBOutlet weak var groupBTN: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.register(UINib.init(nibName: "ManageUserCellTableViewCell", bundle: nil), forCellReuseIdentifier: "addGro")
        self.navigationItem.title = "添加员工"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(submit))
        self.tableview.tableFooterView = UIView()
        self.tableview.delegate = self
        loadData()

    }
    
    @objc func submit(){
        
        
        
    }
    func loadData(){
        
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        params["token"] = UserAccount.loadUserAccount()?.token;
GroupInfoViewModel.sharedInstance.GetUserGroupOnGroupde(params: params as! [String : AnyObject], orVC: self) {
            
        }
    }


}


extension AddGroupToUsersViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mode?.users.count ?? 0
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "addGro", for: indexPath) as! ManageUserCellTableViewCell
        if cell == nil {
           cell = ManageUserCellTableViewCell()
        }
        cell.mode = mode?.users[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mode:User = (self.mode?.users[indexPath.row])!
        mode.isAdd = !mode.isAdd
        
        
        
        
        
        self.tableview.reloadRows(at: [indexPath], with: .automatic)
        
        
        
        
    }
}
