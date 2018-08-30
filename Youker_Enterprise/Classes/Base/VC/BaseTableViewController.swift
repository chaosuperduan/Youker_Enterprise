//
//  BaseTableViewController.swift
//  youke
//
//  Created by keelon on 2018/5/26.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    lazy var editView:EditView = {
       let view1  = EditView.LoadFromNib()
       view1.frame = CGRect.init(x: 0, y: KScreenH-64-tabBarbottomHeight, width: KScreenW, height: 64+tabBarbottomHeight)
        
        return view1
        
    }()
    var isEidt:Bool = false
     //override var isEditing: Bool
    
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    var Tpview:TypeView? = TypeView()
    var isMore:Bool = false 
    var ReqType:RequestResultType?{
        didSet{
            switch ReqType {
            case .SUCCESS?:do {
                self.Tpview?.removeFromSuperview()
            SVProgressHUD.showSuccess(withStatus: "数据加载成功")
            }
                break
            case .ERROR?: do{
                SVProgressHUD.showError(withStatus: self.errorMessage)
            }
                break
            case .NETBAD?: do{
                SVProgressHUD.showError(withStatus: "网络错误")
                Tpview?.text = "网络断开请刷新试一试"
                Tpview?.imageName = "emptynoData"
            self.tableView.addSubview(self.Tpview!)
            }
                break
            case .NODATA?: do{
                Tpview?.text = "没有任何数据"
                Tpview?.imageName = "emptynoData"
                self.tableView.addSubview(self.Tpview!)
            }
                break
            default:
                break
            }
        }
    }
    var errorMessage:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(loadDatas))
        header.beginRefreshing()
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreDatas))
        self.tableView.mj_footer = footer
    }
    
   @objc  func loadDatas(){
        
        header.endRefreshing()
        
        
    }
    @objc func loadMoreDatas(){
        
        
        footer.endRefreshing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
 
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    
    

  

}
