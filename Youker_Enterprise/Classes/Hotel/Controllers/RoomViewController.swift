//
//  RoomViewController.swift
//  youke
//
//  Created by keelon on 2018/6/28.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    @IBOutlet weak var pictureContentView: UIView!
    var introduce:String?
    var room:Room?
    var  priceToken:String?
    var searchParam:SearchParamModel?
    var recordOrder:orderRecord?
  
    @IBOutlet weak var faciaContentView: UIView!
    
    @IBOutlet weak var commentView: UIView!
    
    
    @IBOutlet weak var commentTextView: UITextView!
    
    
    @IBOutlet weak var priceBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      func setUpUI(){
        navigationItem.title = room?.room_Name
         let cycleView : CycleView = CycleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 194))
        cycleView.delegate = self
        cycleView.mode = .scaleAspectFill
        //本地图片测试--加载网络图片,请用第三方库如SDWebImage等
        cycleView.imageURLStringArr = room?.pictures
        //let _:String = room?.has_Window
        cycleView.title = (room?.roomArea!)! + "| " + (room?.bed_commoment!)! + " |" + "有窗" + " |" + "不含早餐"
        self.pictureContentView.addSubview(cycleView)
        let faView = facilitiesView()
        faView.frame  = faciaContentView.bounds
        faView.mode = self.room
        self.faciaContentView.addSubview(faView)
        self.commentTextView.text = self.introduce
        
        let nsInteger = NSDate.daysCalculate(searchParam?.checkInDate, endDays: searchParam?.leaveDate)
        
        //let price:String =
        let m = (room?.bookSUM)!*NSInteger((searchParam?.price)!)
        let priceText:String = "￥" + "\(m)"
        self.priceBTN.setTitle(priceText, for: .normal)
    }
    
    
    @IBAction func book(_ sender: Any) {
        
        let vc = PlaceOrderViewController()
        vc.mode = self.room
        vc.params = self.searchParam
        vc.recordOrder = self.recordOrder
        
        
        vc.priceToken = self.priceToken
    self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension RoomViewController: CycleViewDelegate{
    func cycleViewDidSelectedItemAtIndex(_ index: NSInteger) {
        print(index)
    }
    
    
}
