//
//  HotelListTableViewController.swift
//  youke
//


//  Created by keelon on 2018/5/26.
//  Copyright © 2018年 M2Micro. All rights reserved.
//
import UIKit
let hotelL = "hotelList"

class HotelListTableViewController: BaseTableViewController {
    var priceToken:String?
    var hotellist:[HotelModel] = [HotelModel](){
        
        didSet{
            if hotellist.count>0 {
                self.tableView.reloadData()
                imageView.removeFromSuperview()
            }
        }
    }
    var params:SearchParamModel?
    var imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultStyle(.dark)
      self.navigationItem.title = "正在抢单"
         NotificationCenter.default.addObserver(self, selector: #selector(self.networkDidReceiveMessage(notification:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
        setUpUI()
        SearchHotelViewModel.sharedInstance.getConfirmHotel(origionVc: self)
        
    }
    @objc func networkDidReceiveMessage(notification:NSNotification){
        imageView.stopAnimating()
        imageView.removeFromSuperview()
        var userInfo =  notification.userInfo!
        //获取推送内容
        let content =  userInfo["content"] as! String
        
        let data = content.data(using: .utf8)
        
        let dic:[String:AnyObject] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
//        let str :String = dic["title"] as! String
//        print(str)
//        if str == "null"{
//
//            self.ReqType = RequestResultType.NODATA
//
//            return
//        }
//        let data1 = str.data(using: .utf8)
//        let dic2:[[String:AnyObject]] = try! JSONSerialization.jsonObject(with: data1!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : AnyObject]]
//        for dic in dic2 {
//            let mode:HotelModel = HotelModel(dict: dic as! [String : NSObject])
//            hotellist.append(mode)
//        }
//        SearchHotelViewModel.sharedInstance.getConfirmHotel(origionVc: self)
        tableView.reloadData()
    }
    
    
    override func loadMoreDatas() {
        
        SearchHotelViewModel.sharedInstance.getMoreConfirmHotel(origionVc: self)
        
        
    }
    
    func stopRefresh(){
        
        self.tableView.mj_footer.endRefreshing()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return hotellist.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: hotelL, for: indexPath) as! HotelListTableViewCell
        if cell == nil {
            cell = HotelListTableViewCell()
        }
        cell.hotel = hotellist[indexPath.row]
        cell.mode = self.params
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = HotelViewController()
        vc.priceToken = self.priceToken
        vc.mode = hotellist[indexPath.row]
        vc.params = params
    navigationController?.pushViewController(vc, animated: true)
    }
}
extension HotelListTableViewController{
    func setUpUI(){
        tableView.register(UINib.init(nibName: "HotelListTableViewCell", bundle: nil), forCellReuseIdentifier: hotelL)
      tableView.rowHeight = 164
      //self.imageView.frame = self.view.bounds
      //self.view.addSubview(self.imageView)
        
      //tableView.addSubview(self.imageView)
        guard let path = Bundle.main.path(forResource: "5-160914192R6-52.gif", ofType: nil),
            let data = NSData(contentsOfFile: path),
            let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<CGImageSourceGetCount(imageSource) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            i == 0 ? imageView.image = image : ()
            imageView.size = image.size
            images.append(image)
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary,
                let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary,
                let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        imageView.frame = view.bounds
        imageView.center = view.center
        imageView.center.y = view.center.y - 40
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        tableView.tableFooterView = UIView()
    }
}

