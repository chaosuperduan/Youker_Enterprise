//
//  LimitManageViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LimitManageViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var minTF: UITextField!
    @IBOutlet weak var maxTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
     var users:[NSInteger] = [NSInteger]()
    var groupID:NSInteger = 0
    var mode:UserGroupModel?{
        didSet{
            if minTF != nil {
            minTF.text = "\(mode?.minPrice)"
            }
            
            if maxTF != nil  {
                  maxTF.text  = "\(mode?.maxPrice)"
            }
            
          
        }
        
    }
    
    var DataMode:UserGroupModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)

        
    }
    func setUpUi(){
      self.navigationItem.title = mode?.group_Name
      
      
        tableview.register(UINib.init(nibName: "ManageUserCellTableViewCell", bundle: nil), forCellReuseIdentifier: "lm")
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "pl"), style: .plain, target: self, action: #selector(add))
        self.tableview.tableFooterView =  UIView()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        minTF.text = "\(mode!.minPrice)"
        maxTF.text  = "\(mode!.maxPrice)"
        minTF.delegate = self
        maxTF.delegate = self
    }
    
    
   @objc  func add(){
    let vc = AddGroupToUsersViewController()
    vc.ADDmode = self.mode
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func next(){
        
        
        let vc = AddGroupToUsersViewController()
//        vc.mode = self.mode
    
    self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    //修改分组信息
    
    func editGroupInfo(){
        
        
        
    }
    
    //MARK:调用编辑编辑功能
    @objc func textFieldDidChange(){
        
       
    }
    
    
    
}

extension LimitManageViewController:UITableViewDataSource,UITableViewDelegate{
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
    
    //选中的x做出删除操作。
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //删除了
        
        
        self.users.removeAll()
        
        let ind = (self.DataMode?.users[indexPath.row])!.user_Id
        self.users.append(ind)
        let popView = ZXPopView.init(frame: self.view.bounds)
        let actionView = ActionView.LoadFromNib()
        actionView.callBack = { isdone in
            if isdone {
                
                self.deleteUserToGroup(index: indexPath.row)
                popView.dismissView()
            }else{
                
                popView.removeFromSuperview()
                
            }
            
        }
        
        actionView.frame = CGRect.init(x: (KScreenW-325)/2, y: (KScreenH-167)/2, width: 325, height: 167)
        popView.contenView = actionView
        popView.isCenter = true
        popView.showInView(view: self.view)
        
    }
    
    
    func deleteUserToGroup(index:NSInteger){
        
     
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        params["groupId"] = mode?.group_Id
        params["operateUser"] = UserAccount.loadUserAccount()?.user_Id
        //params["users"]
        
        params["token"] = UserAccount.loadUserAccount()?.token!
        
        let data = try? JSONSerialization.data(withJSONObject: users, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        
        params["users"] = strJson
        
        GroupInfoViewModel.sharedInstance.DelteUserToGroup(params: params as! [String : AnyObject], orVC: self) {
            self.loadData()
        }
        
        
    }
    
    
    
    
    
}
