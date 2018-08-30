//
//  BindingAccountTableViewController.swift
//  youke
//
//  Created by keelon on 2018/7/12.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class BindingAccountTableViewController: UITableViewController {
    let titles = ["微信钱包","支付宝"]
    let types = [85,84]
    let icons = ["weichat","zhifu"]
    var accounts:[String]?
    var dataArray:[PayAccount] = [PayAccount]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "绑定账户"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "bind")
        self.tableView.rowHeight = 60
        self.tableView.tableFooterView = UIView()
        loadData()
    }
    
    func loadData(){
       let params = NSMutableDictionary()
        let account:UserAccount = UserAccount.loadUserAccount()!
        params["userId"] = UserAccount.loadUserAccount()!.user_Id
        let token:String = account.token!

        params["token"] = token
        //print(params["token"] ?? )
    
        BlindViewModel.sharedInstance.GetAccount(params: params as! [String : AnyObject], orVC: self, callback: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 2
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "bind", for: indexPath)

        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "bind")
        }
        
        if (self.dataArray.count) > 0 {
            
            let acc = dataArray[indexPath.row]
            
            if acc.account_Number == nil{
                
                
                if(acc.account_Type == 84){
                    cell.textLabel?.text =  "支付宝"
                    cell.imageView?.image = UIImage.init(named: "plus")
                    
                }else{
                    cell.textLabel?.text =  "微信"
                    cell.imageView?.image = UIImage.init(named: "plus")
                    
                }
                
                
            }else{
                cell.imageView?.image = UIImage.init(named: acc.accountIcon!)
                cell.textLabel?.text = acc.account_Number
                
            }
            
            
            
            
        }else{
            
            cell.textLabel?.text = titles[indexPath.row]
            cell.imageView?.image = UIImage.init(named: "plus")
        }
        cell.textLabel?.textColor = UIColor.lightGray
        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc :AddAcountViewController = AddAcountViewController()
        vc.addType = indexPath.row
        
        if (self.dataArray.count)>0 {
            
            let mode = self.dataArray[indexPath.row]
            if(mode.account_Number != nil){
               vc.isUpdate = true
                
            }
            vc.addType = self.dataArray[indexPath.row].account_Type
        }else{
            
            vc.addType = self.types[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

