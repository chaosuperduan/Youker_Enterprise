//
//  TimeTool.swift
//  youke
//
//  Created by keelon on 2018/6/1.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class TimeTool: NSObject {

    /// MARK --将NSInteger转成DATA字符串
   class func getTimeStrWithInt(time:NSInteger)->String{
        let string = NSString(string: "\(time)")
    print(string)
    let timeSta:TimeInterval = TimeInterval(time)/1000
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd"
    //1528473600000
    let date = NSDate(timeIntervalSince1970: timeSta)
    print(dfmatter.string(from: date as Date))
    return dfmatter.string(from: date as Date)
    }
    /// MARK --将NSInteger转成DATA字符串
    ///比较两个时间字符串的大小。
}
