//
//  LimitationViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

//限额管理

import UIKit

class LimitationViewController: BaseViewController {

    var dataArray:[UserGroupModel] = [UserGroupModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
       setUp()
        
        
    }
    func setUp(){
        
        let Lv = LimitView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: 220))
        self.navigationItem.title = "限额管理"
        Lv.callback = { index  in
            
            if index == Lv.dateArray.count-1 {
                
                self.showActionSheetView(Lv: Lv)
                
            }else{
              let vc = LimitManageViewController()
              vc.mode = self.dataArray[index]
                
              //vc.groupID =
              self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            
         
            
        }
        view.addSubview(Lv)
        loadData {
            Lv.dateArray = self.dataArray
            
            
            Lv.collectionview?.reloadData()
        }
    
    }
    //添加企业分组信息。
    func  addGroupInfo(vi:LimitView,mode:UserGroupModel,callback:@escaping ()->()){
    let params = NSMutableDictionary()
    params["token"] = UserAccount.loadUserAccount()?.token!
        print(params["token"] ?? "d")
    params["groupInfo"] = String.getJSONStringFromDictionary(dictionary: UserGroupModel.getDic(mode: mode))
        
    params["userId"] = UserAccount.loadUserAccount()?.user_Id
   GroupInfoViewModel.sharedInstance.AddGroupInfo(params:params as! [String : AnyObject] , orVC: self) {
    if(callback != nil){
        callback()
    }
    }
    
    }
    //显示分组弹窗页面。
    func showActionSheetView(Lv:LimitView){
        let popview = ZXPopView.init(frame: self.view.bounds)
        let vlView = LimitActionView.LoadFromNib()
        vlView.frame = CGRect.init(x: (KScreenW-315)/2, y: (KScreenH-156)/2, width: 315, height: 156)
        vlView.callback = { index in
            popview.removeFromSuperview()
            if index == 1 {
                
                if((vlView.NameTF.text?.count)!>0){
                    let mode  = UserGroupModel(dict: [String:AnyObject]() as! [String : NSObject])
                    mode.group_Name = vlView.NameTF.text
                    mode.company_Id = UserAccount.loadUserAccount()?.company_Id as! NSInteger
                    mode.maxPrice = 50
                    mode.minPrice = 20
                    //mode.imge = "blueT"
                    //Lv.dateArray.insert(mode, at: 0)
                    // Lv.collectionview?.reloadData()
                    self.addGroupInfo(vi: Lv, mode: mode, callback: {
                        self.loadData(callback: {
                            Lv.dateArray = self.dataArray
                            Lv.collectionview?.reloadData()
                            
                        })
                        
                        
                    })
                    
                    
                }
            }
        }
        popview.isCenter = true
        popview.contenView = vlView
        popview.showInView(view: self.view)
    }
}
//加载数据。

extension LimitationViewController{
    
    func loadData(callback:(()->())?){
        
        let params = NSMutableDictionary()
        params["companyId"] = UserAccount.loadUserAccount()?.company_Id
        
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        
        params["token"] = UserAccount.loadUserAccount()?.token;
        GroupInfoViewModel.sharedInstance.GetGroupInfomation(params: params as! [String : AnyObject], orVC: self, callback1: {
            
            if(callback != nil){
               callback!()
                
            }
            
            
        })
        
    }
}



