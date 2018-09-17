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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        
        
    }
    
    func setUpUi(){
        self.navigationItem.title = "添加管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "pl"), style: .plain, target: self, action: #selector(add))
        self.tableView.register(UINib.init(nibName: "ManageUserCellTableViewCell", bundle: nil), forCellReuseIdentifier: "add")
        
    }
    @objc func add(){
        
        let vc :UIViewController = UIViewController()
        
        
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
        return DataMode?.users.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "add", for: indexPath) as! ManageUserCellTableViewCell
        
        if cell == nil  {
            
            cell = ManageUserCellTableViewCell()
            
            
            
        
        }
        cell.mode = self.DataMode?.users[indexPath.row]

       

        return cell
    }


   

}
