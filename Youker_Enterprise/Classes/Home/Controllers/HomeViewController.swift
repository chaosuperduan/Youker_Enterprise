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
       let secView = HomeHeaderView.init(frame: CGRect.init(x: 0, y: 200, width: KScreenW, height: 164))
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
    

}



