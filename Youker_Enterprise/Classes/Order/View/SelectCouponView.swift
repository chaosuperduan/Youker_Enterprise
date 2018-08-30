//
//  SelectCouponView.swift
//  youke
//
//  Created by keelon on 2018/7/8.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
let selectCoupon = "selectCoupon"
class SelectCouponView: UIView,NibLoad{

    @IBOutlet weak var tableView: UITableView!
    override init(frame: CGRect) {
        super.init(frame: frame)
     // setUpUI()
    }
    func loadFromLib(){
      
    }

    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
       //setUpUI()
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @IBAction func all_Select(_ sender: Any) {
        
        
        
    }
    
    func setUpUI(){
        
       self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "SelectCouponTableViewCell", bundle: nil), forCellReuseIdentifier: selectCoupon)
        self.tableView.rowHeight = 95
        self.tableView.reloadData()
    }
}

extension SelectCouponView:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: selectCoupon, for: indexPath) as! SelectCouponTableViewCell
        if cell == nil {
            cell = SelectCouponTableViewCell()
        }
        
        return cell
    }
    func load(){
        
        loadFromLib()
        setUpUI()
    }
    
    
}
