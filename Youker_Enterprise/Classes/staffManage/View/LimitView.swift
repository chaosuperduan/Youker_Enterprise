//
//  LimitView.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LimitView: UIView {
    var collectionview:UICollectionView?
    let titles = ["管理员","高管","普通员工","自定义"]
    let imgs = ["blueT","redT","lanT","grayT"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUi(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize.init(width: (KScreenW-80)/3, height: 90)
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        self.collectionview = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionview?.dataSource = self
        self.collectionview?.frame.size.width = KScreenW
        self.collectionview?.height = 220
        self.collectionview?.dataSource = self
        self.collectionview?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "limit")
        collectionview?.backgroundColor = UIColor.white
        //self.collectionView?.backgroundColor  = UIColor.red
        print(collectionview?.frame)
        addSubview(collectionview!)
        
    }
}

extension LimitView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "limit", for: indexPath) as! UICollectionViewCell
        if cell == nil {
            cell = UICollectionViewCell()
            cell.backgroundColor = UIColor.randomColor()
        }
        cell.backgroundColor = UIColor.randomColor()

        let imgV = UIImageView.init(image: UIImage.init(named: imgs[indexPath.item]))
        cell.addSubview(imgV)
        imgV.center.x = cell.center.x
        imgV.center.y = cell.center.y
        imgV.size = CGSize.init(width: 90, height: 90)
        let lb = UILabel()
        lb.height = 18
        lb.center = cell.center
        lb.text = titles[indexPath.item]
        cell.addSubview(lb)
        return cell
        
    }
    
}
