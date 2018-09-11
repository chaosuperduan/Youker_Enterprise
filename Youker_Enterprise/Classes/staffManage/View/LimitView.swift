//
//  LimitView.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LimitView: UIView,NibLoad {
    var collectionview:UICollectionView?
//    let titles = ["管理员","高管","普通员工","自定义"]
//    let imgs = ["blueT","redT","LanT","grayT"]
 lazy    var dateArray:[EditGroup] = {
       let mode = EditGroup()
       mode.title = "自定义"
       mode.imge = "grayT"
        var datearray = [EditGroup]()
        datearray.append(mode)
        
        return datearray
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUi()
    }
   var callback:((NSInteger)->())?
    
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
//        self.collectionview?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "limit")
        self.collectionview?.register(UINib.init(nibName: "LimitCell", bundle: nil), forCellWithReuseIdentifier: "limit")
        collectionview?.backgroundColor = UIColor.white
        //self.collectionView?.backgroundColor  = UIColor.red
        collectionview?.delegate = self
        print(collectionview?.frame)
        addSubview(collectionview!)
        
    }
}

extension LimitView: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "limit", for: indexPath) as! LimitCell
        if cell == nil {
            cell = LimitCell()
            cell.backgroundColor = UIColor.randomColor()
        }
        cell.titleLabel.text = dateArray[indexPath.item].title
        cell.imgView.image = UIImage.init(named: dateArray[indexPath.item].imge!) //dateArray[indexPath.item].imge

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.callback == nil {
            
            return
        }
        self.callback!(indexPath.item)
    }

    
}
