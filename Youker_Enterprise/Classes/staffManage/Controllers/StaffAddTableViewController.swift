//
//  StaffAddTableViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import SnapKit
class StaffAddTableViewController: UITableViewController {
    let titles = ["手动添加","扫码添加"]
    let imgs = ["finger","coder"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpui()

       
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "staff", for: indexPath)

        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "staff")
        }
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.textColor = UIColor.gray
        let imgV:UIImageView = UIImageView.init(image: UIImage.init(named: imgs[indexPath.row]))
      
       cell.contentView.addSubview(imgV)
  
        imgV.snp_makeConstraints { (make) in
        make.right.equalTo(cell.contentView).offset(-20)
        make.width.equalTo(31)
        make.height.equalTo(31)
        make.centerY.equalTo(cell.contentView.centerY)

        }
        
        

        return cell
    }
  
    
    func setUpui(){
     self.navigationItem.title = "添加企业员工"
     tableView.register(UITableViewCell.self, forCellReuseIdentifier: "staff")
     tableView.tableFooterView = UIView()
     self.tableView.rowHeight = 64
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            
        }else{
            
            
        }
    }
    

}
