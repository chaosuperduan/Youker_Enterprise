//
//  UpdateInfoViewController.swift
//  YOUKER_MERCHANT
//
//  Created by keelon on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class UpdateInfoViewController: UIViewController {
    
    var buInfo:businessInfo = businessInfo(dict: [String:AnyObject]() as! [String : NSObject])
    

    @IBOutlet weak var hotelNameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var CodeTF: UITextField!
    @IBOutlet weak var CertificateView: UIView!
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var LisenceImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "完善信息"
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    @IBAction func addFrontImage(_ sender: Any) {
        
        self.showCanEdit(true) { (image) in
           self.frontImageView.image = image
            
        }
        
    }
    
    @IBAction func addBackImage(_ sender: Any) {
        
        self.showCanEdit(true) { (image) in
            self.backImageView.image = image
            
        }
        
        
    }
    @IBAction func addLisence(_ sender: Any) {
        self.showCanEdit(true) { (image) in
            self.LisenceImageView.image = image
            
        }
    }
    
    
    @IBAction func submit(_ sender: Any) {
        let params = NSMutableDictionary()
        params["userId"] = UserAccount.loadUserAccount()?.user_Id
        
        params["token"] = UserAccount.loadUserAccount()?.token!
        params["role"] = 6//roleEnum.personalShop.rawValue
        params["cardBack"] = UIImage.transImageToString(imge: backImageView.image!)
        params["uniqueCode"] = 0
        params["cardFace"] = UIImage.transImageToString(imge: frontImageView.image!)
        params["photo"] = UIImage.transImageToString(imge: LisenceImageView.image!)
        buInfo.business_Address = self.addressTF.text
        buInfo.business_Name = self.hotelNameTF.text
        var  DIC = NSMutableDictionary()
        DIC["name"] = self.hotelNameTF.text
        DIC["address"] = self.addressTF.text
        params["busniessInfo"] = String.getJSONStringFromDictionary(dictionary:DIC )
        CertificateMode.sharedInstance.registMerchant(params: params as! [String : AnyObject], orVC: self) {
            
        }
    }
    
 
}
