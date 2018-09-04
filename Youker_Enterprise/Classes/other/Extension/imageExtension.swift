//
//  imageExtension.swift
//  youke
//
//  Created by keelon on 2018/8/6.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import Foundation

import UIKit
extension UIImage{
    ///将照片照片转换成string.
    static func transImageToString(imge:UIImage)->String{
        return   (imge.compressImage(image: imge, maxLength: 200000)?.base64EncodedString())!
    }
    
    
}
