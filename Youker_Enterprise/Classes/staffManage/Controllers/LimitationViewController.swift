//
//  LimitationViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

//限额管理

import UIKit

class LimitationViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Lv = LimitView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: 220))
        self.navigationItem.title = "限额管理"
        Lv.callback = { index  in
            
            let popview = ZXPopView.init(frame: self.view.bounds)

            let vlView = LimitActionView.LoadFromNib()
            vlView.frame = CGRect.init(x: (KScreenW-315)/2, y: (KScreenH-156)/2, width: 315, height: 156)
            vlView.callback = { index in
               popview.removeFromSuperview()
                if index == 1 {
                    if((vlView.NameTF.text?.count)!>0){
                      let mode  = EditGroup()
                      mode.title = vlView.NameTF.text
                      mode.imge = "blueT"
                        Lv.dateArray.insert(mode, at: 0)
                        Lv.collectionview?.reloadData()
                        
                    }
                }
                
            }
            popview.isCenter = true
            popview.contenView = vlView
            popview.showInView(view: self.view)
            

        }

       view.addSubview(Lv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


