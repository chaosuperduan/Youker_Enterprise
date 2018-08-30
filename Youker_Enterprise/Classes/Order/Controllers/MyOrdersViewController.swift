

//
//  MyOrdersViewController.swift
//  youke
//
//  Created by Duan Chao on 2018/5/17.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class MyOrdersViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH+IPXstatusHeight-64, width: kScreenW, height: kTitleViewH)
        let titles = ["全部", "未入住", "已入住"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - IPXstatusHeight
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH+IPXstatusHeight-64, width: kScreenW, height: contentH)
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        let vc1 = TotalTableViewController()
        let vc2 = TotalTableViewController()
        //0是未入住。1是已入住。
        vc2.state = 0
        
        let vc3 = TotalTableViewController()
        vc3.state = 1
        childVcs.append(vc1)
        childVcs.append(vc2)
        childVcs.append(vc3)
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
extension MyOrdersViewController{
    
    func setUpUI(){
        // 1.添加TitleView
        view.addSubview(pageTitleView)
        // 2.添加ContentView
        view.addSubview(pageContentView)
        self.navigationItem.title  = "我的订单"
        let item = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "editItem"), style: .done, target: self, action: #selector(editDone))
        self.navigationItem.leftBarButtonItem  = item;
    }
    //编辑模式。
    @objc func editDone(){
        //self.isEidt = !isEidt
        NotificationCenter.default.post(name: NSNotification.Name.init("EDIT"), object: nil)
        
    }
    
    @objc func back(){
        UIApplication.shared.keyWindow?.viewWithTag(333)
       dismiss(animated: true, completion: nil)
    }
}
extension MyOrdersViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension MyOrdersViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

