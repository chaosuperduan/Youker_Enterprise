//
//  HomeViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
     var hotellist:[HotelModel] = [HotelModel]()
     var param :SearchParamModel = SearchParamModel()
    //设置UI.
    func setUpUi(){
       let header = UserHeaderView.LoadFromNib()
        header.frame = CGRect.init(x: 0, y: 0, width: KScreenW, height: 260)
        print(header.frame)
       let secView = HomeHeaderView.init(frame: CGRect.init(x: 0, y: 270, width: KScreenW, height: 164))
        secView.callback = { index in
            self.doWithIndex(index: index)
        }
      print(secView.frame)
      view.addSubview(header)
      view.addSubview(secView)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //菜单的点击事件。
    func doWithIndex(index:NSInteger){
        switch index {
        case 0:
            let naVi = FWNavigationController.init(rootViewController: ManagementViewController())
            present(naVi, animated: true, completion: nil)
            
        
            break
        case 3:
            let naVi = FWNavigationController.init(rootViewController: StaffAddTableViewController())
            present(naVi, animated: true, completion: nil)
            break
        default:
            break
        }
        
    }
}



