//
//  SystemableViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/15.
//  Copyright © 2018年 apple. All rights reserved.
//系统设置
private let titles = ["更改密码","关于我们","软件升级","退出登录"]

import UIKit

class SystemableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settting")
      self.navigationItem.title = "系统设置"
      self.tableView.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: .plain, target: self, action: #selector(back))

    }
    
    @objc func back(){
        
        dismiss(animated: true, completion: nil)
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
        return titles.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settting", for: indexPath)
        
        if cell == nil {
            
            
            
            
            
            
        }

        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.textColor = UIColor.gray
        

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        switch indexPath.row {
        case 0:
            
         let vc  =  ModifyPasswordViewController()
         self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            //showCodeView()
            
            break
        case 3:
          UserAccount.loadUserAccount()?.removeAll()
            break
        default:
            break
        }
    }
    
   
    
}
