//
//  InviteTableViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/8.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class InviteTableViewController: BaseTableViewController {
    var isJoin:Bool = false
    var dataArray:[User] = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatas()
        self.tableView.register(UINib.init(nibName: "InviteTableViewCell", bundle: nil), forCellReuseIdentifier: "invite")
        self.tableView.tableFooterView  = UIView()

       
    }
    override func loadDatas() {
        if self.dataArray.count>0 {
            self.dataArray.removeAll()
        }
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        params["token"] = UserAccount.loadUserAccount()?.token!
        params["state"] = isJoin ? 134:133
        params["operateUser"] = UserAccount.loadUserAccount()?.user_Id
        
        InviteViewModel.sharedInstance.GetInviteUsers(params: params as! [String : AnyObject], orVC: self) {
            
        }
        
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
        return self.dataArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invite", for: indexPath) as! InviteTableViewCell

        if cell == nil  {
            cell == InviteTableViewCell()
        }
        cell.user = self.dataArray[indexPath.row]

        return cell
    }

   

}
