//
//  FirstViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func registerEnterprise(_ sender: Any) {
        
        present(RegisterViewController(), animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
        
        
    }
    

}
