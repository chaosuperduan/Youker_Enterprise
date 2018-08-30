//
//  ShareView.swift
//  youke
//
//  Created by keelon on 2018/7/11.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
let shareC = "shareC"
class ShareView: UIView {
    var callBack:((Int)->())?
    var collectionView :UICollectionView?
    var titles:[String] = ["微信好友","微信朋友圈","新浪微博","QQ好友","QQ空间"]
    var images:[String] = ["wechat","pyq","sinaWeibo","qq","QQ_zone"]
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 40
        layout.minimumLineSpacing = 20
        
        layout.itemSize = CGSize.init(width: (KScreenW-120)/3, height: 80)
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView?.delegate = self
        self.collectionView?.frame.size.width = KScreenW
        self.collectionView?.height = 200
        self.collectionView?.dataSource = self
        self.collectionView?.register(UINib.init(nibName: "ShareCell", bundle: nil), forCellWithReuseIdentifier: shareC)
        collectionView?.backgroundColor = UIColor.white
        print(collectionView?.frame)
        addSubview(collectionView!)
        
    }

}

extension ShareView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: shareC, for: indexPath) as! ShareCell
        if cell == nil {
            cell = ShareCell()
            cell.backgroundColor = UIColor.randomColor()
        }
        //cell.backgroundColor = UIColor.randomColor()
        
        cell.iconImageView.image = UIImage.init(named: images[indexPath.row])
       cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
}

extension ShareView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if callBack != nil  {
            self.callBack!(indexPath.item)
            
        }
    }
}
