//
//  LimitManageViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LimitManageViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var minTF: UITextField!
    @IBOutlet weak var maxTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    var mode:UserGroupModel?
    
    var DataMode:UserGroupModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        loadData()

        
    }
    func setUpUi(){
      self.navigationItem.title = mode?.group_Name
      
      
        tableview.register(UINib.init(nibName: "ManageUserCellTableViewCell", bundle: nil), forCellReuseIdentifier: "lm")
        self.tableview.tableFooterView = UIView()
        self.tableview.dataSource = self
    }
    
    func loadData(){
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        params["groupId"] = mode?.group_Id
        params["operateUser"] = UserAccount.loadUserAccount()?.user_Id
        
       params["token"] = UserAccount.loadUserAccount()?.token!
        
        GroupInfoViewModel.sharedInstance.GetGroupAndUser(params: params as! [String : AnyObject], orVC: self, callback1: {
            
            
            
        })
    }
}

extension LimitManageViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DataMode?.users.count ?? 0)
        print("_*^")
        return DataMode?.users.count ?? 0
        print("_*^")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "lm", for: indexPath) as! ManageUserCellTableViewCell
        if cell == nil {
            
            cell = ManageUserCellTableViewCell()
        }
        cell.mode = self.DataMode?.users[indexPath.row]
        
        
        return cell
        
    }
    
}
