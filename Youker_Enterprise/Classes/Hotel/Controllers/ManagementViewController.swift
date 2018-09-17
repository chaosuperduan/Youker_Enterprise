//
//  ManagementViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/1.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
private let titles = ["企业员工管理","限额管理","权限管理"]
private let imgs = ["yuangong","xianer","quanxian"]
class ManagementViewController: BaseViewController {

    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        
    }
    
    
     func loadData(){
          let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        
        
        
      GroupInfoViewModel.sharedInstance.GetCompanyAdmin(params: <#T##[String : AnyObject]#>, orVC: <#T##AddAdminTableViewController?#>, callback1: <#T##(() -> ())##(() -> ())##() -> ()#>)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func setUpUi(){
        self.navigationItem.title = "管理中心"
        self.tableview.delegate = self
        self.tableview.dataSource = self
        let heView = UserHeaderView.LoadFromNib()
        heView.frame = self.header.bounds
        header.addSubview(heView)
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "ii")
        self.tableview.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: .plain, target: self, action: #selector(back))
    }
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }
    
}

extension ManagementViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "ii", for: indexPath)
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "ii")
        }
        cell.imageView?.image = UIImage.init(named: imgs[indexPath.row])
        cell.textLabel?.text = titles[indexPath.row]
        cell.accessoryType = .detailButton
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(ManageEnterUserTableViewController(), animated: true)
            break
        case 1:
            let vc = LimitationViewController()
            
            self.navigationController?.pushViewController(LimitationViewController(), animated: true)
            break
        case 2:
            let vc = AddAdminTableViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
    
}
