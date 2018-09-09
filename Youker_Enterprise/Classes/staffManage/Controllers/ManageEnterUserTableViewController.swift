//
//  ManageEnterUserTableViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ManageEnterUserTableViewController: BaseTableViewController{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpUI()
        

        
    }
    
    override func loadDatas() {
        
        
    }

  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 0
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
