//
//  UpdateInfoViewController.swift
//  YOUKER_MERCHANT
//
//  Created by keelon on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class UpdateInfoViewController: UIViewController {
    @IBOutlet weak var cpADDBTN: UIButton!
    
    @IBOutlet weak var RegAddBTN: UIButton!
    var buInfo:cpyInfo = cpyInfo(dict: [String:AnyObject]() as! [String : NSObject])
    var dist:districts = districts(dict: [String:AnyObject]() as! [String : NSObject])

    @IBOutlet weak var copNameTF: UITextField!
    
    @IBOutlet weak var addressTF: UITextField!
    
    @IBOutlet weak var detailAddress: UITextField!
    @IBOutlet weak var CodeTF: UITextField!
    @IBOutlet weak var CertificateView: UIView!
    
    @IBOutlet weak var copPhoneTF: UITextField!
    @IBOutlet weak var countPhone: UITextField!
    
    @IBOutlet weak var regAddTF: UITextField!
    
    @IBOutlet weak var RegDetailTF: UITextField!
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var LisenceImageView: UIImageView!
    
    @IBOutlet weak var lawPerson: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "完善信息"
        self.cpADDBTN.setTitle(self.dist.cpyCity, for: .normal)
        

    }
    @IBAction func addCommpayAdd(_ sender: Any) {
        KeybordDown()
        let cView = CityPickerVeiw()
        cView.show()
         cView.cityBlock = { (pro,city,dis) in
        self.dist.cpyCity = city
            self.dist.cpyDistrict = dis
            self.cpADDBTN.setTitle(self.dist.cpyCity, for: .normal)
        }
    }
    //添加注册地址.
    @IBAction func addRegAdd(_ sender: Any) {
        KeybordDown()
        let cView = CityPickerVeiw()
        cView.show()
        cView.cityBlock = { (pro,city,dis) in
            self.dist.regCity = city
            self.dist.regDistrict = dis
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    @IBAction func addFrontImage(_ sender: Any) {
        KeybordDown()
        self.showCanEdit(true) { (image) in
           self.frontImageView.image = image
        }
    }
    
    @IBAction func addBackImage(_ sender: Any) {
        KeybordDown()
        self.showCanEdit(true) { (image) in
            self.backImageView.image = image
            
        }
    }
    @IBAction func addLisence(_ sender: Any) {
        KeybordDown()
        self.showCanEdit(true) { (image) in
            self.LisenceImageView.image = image
            
        }
    }
    
    //提交数据。
    @IBAction func submit(_ sender: Any) {
        
        
        buInfo.company_Name = self.copNameTF.text
        buInfo.company_Phone = copPhoneTF.text
        buInfo.userCount = countPhone.text
        buInfo.usccode = CodeTF.text
        buInfo.company_Address = detailAddress.text
        buInfo.law_person_Name = lawPerson.text
        let acc = UserAccount.loadUserAccount()
        
    
        let params = NSMutableDictionary()
        params["userId"] = acc?.user_Id
        
        params["token"] = UserAccount.loadUserAccount()?.token!
       // params["role"] = 6//roleEnum.personalShop.rawValue
        params["cardBack"] = UIImage.transImageToString(imge: backImageView.image!)
        //params["uniqueCode"] = 0
        params["cardFace"] = UIImage.transImageToString(imge: frontImageView.image!)
        params["license"] = UIImage.transImageToString(imge: LisenceImageView.image!)
        buInfo.company_Address = self.addressTF.text
        buInfo.company_Name = self.copNameTF.text
        params["districts"] = String.getJSONStringFromDictionary(dictionary:districts.getDic(mode: self.dist))

        params["cpyInfo"] = String.getJSONStringFromDictionary(dictionary:cpyInfo.getDic(mode: self.buInfo) )
        CertificateMode.sharedInstance.registMerchant(params: params as! [String : AnyObject], orVC: self) {
            //跳转控制器。
          UIApplication.shared.keyWindow?.rootViewController = HomeViewController()
            
        }
    }
}
extension UpdateInfoViewController{
    func KeybordDown(){
      copNameTF.resignFirstResponder()
      detailAddress.resignFirstResponder()
    copPhoneTF.resignFirstResponder()
        countPhone.resignFirstResponder()
        CodeTF.resignFirstResponder()
        lawPerson.resignFirstResponder()
        RegDetailTF.resignFirstResponder()
        }
}


