//
//  facilitiesView.swift
//  youke
//
//  Created by keelon on 2018/6/29.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
let fa = "facell"
class facilitiesView: UIView {
    var mode:Room?{
        
        didSet{
            
            self.collectionView?.reloadData()
        }
    }
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
        
        layout.itemSize = CGSize.init(width: (KScreenW-150)/4, height: 80)
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

extension facilitiesView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (mode?.facilities?.count) ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: fa, for: indexPath) as! facilitiesCell
        if cell == nil {
            cell = facilitiesCell()
         cell.backgroundColor = UIColor.randomColor()
        }
        //cell.backgroundColor = UIColor.randomColor()
        
        cell.iconImageView.image = UIImage.init(named: (mode?.facilities![indexPath.row])!)
        cell.nameLabel.text = mode?.equipment![indexPath.row]
        return cell
    }
    
}



