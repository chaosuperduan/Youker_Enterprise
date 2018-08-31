//
//  HomeHeaderView.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/8/31.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var titles = ["管理中心","我的订单","我的消息","邀请员工","系统设置"]
    var images = ["mangament","orders","mes_ent","invite","set_ent"]
    var collectionView:UICollectionView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setUpUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUi(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 20
        
        layout.itemSize = CGSize.init(width: (KScreenW-3)/4, height: 80)
        layout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
        self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView?.dataSource = self
        self.collectionView?.frame.size.width = KScreenW
        self.collectionView?.height = 200
        self.collectionView?.dataSource = self
        self.collectionView?.register(UINib.init(nibName: "facilitiesCell", bundle: nil), forCellWithReuseIdentifier: fa)
        collectionView?.backgroundColor = UIColor.white
        //self.collectionView?.backgroundColor  = UIColor.red
        print(collectionView?.frame)
        addSubview(collectionView!)
    }
    
}

extension HomeHeaderView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return (mode?.facilities?.count) ?? 0
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: fa, for: indexPath) as! ButtonCell
        if cell == nil {
            cell = ButtonCell()
            cell.backgroundColor = UIColor.white
        }
        //cell.backgroundColor = UIColor.randomColor()
        
//        cell.iconImageView.image = UIImage.init(named: (mode?.facilities![indexPath.row])!)
//        cell.nameLabel.text = mode?.equipment![indexPath.row]
        return cell
    }
    
}
