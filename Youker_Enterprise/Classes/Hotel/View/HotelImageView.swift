//
//  HotelImageView.swift
//  youke
//
//  Created by Duan Chao on 2018/5/18.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
private let ImgeViewCellID = "kCycleCellID"
class HotelImageView: UIView,NibLoad {

    var cycleTimer : Timer?
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pictures:[String] = [String](){
        didSet{
            
           
        }
        
        
    }
    
    var mode:Room?{
        didSet{
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = mode?.pictures.count ?? 0
            
            // 3.默认滚动到中间某一个位置
            //let indexPath = IndexPath(item: (mode?.pictures.count ?? 0) * 10, section: 0)
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
// 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
         //注册Cell
        collectionView.register(UINib(nibName: "ImgeViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImgeViewCellID)
        
        collectionView.delegate = self
        
        collectionView.register(UINib.init(nibName: "ImgeViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:ImgeViewCellID )
        collectionView.dataSource = self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
// MARK:- 遵守UICollectionView的数据源协议
extension HotelImageView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mode?.pictures.count ?? 0) * 10000
       // return pictures.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImgeViewCellID, for: indexPath) as!ImgeViewCollectionViewCell
        //cell.backgroundColor = UIColor.randomColor()
        cell.picture = mode?.pictures[indexPath.item%(mode?.pictures.count)!]
        return cell
    }
}

extension HotelImageView:UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        print(offsetX)
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (mode?.pictures.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}

// MARK:- 对定时器的操作方法
extension HotelImageView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
        
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x/collectionView.width
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

