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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
