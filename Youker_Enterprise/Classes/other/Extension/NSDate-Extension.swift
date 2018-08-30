//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import Foundation


extension Date {
    static func getCurrentTime() -> String {
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd"
        return timeFormatter.string(from: date as Date) as String
    }
    
    static func getCurrentTimeByMonth() -> String {
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "MM-dd "
        return timeFormatter.string(from: date as Date) as String
    }
    static func getTomorrowTime()->String{
        let date = NSDate.dateTomorrow()
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd"
        return timeFormatter.string(from: date as! Date) as String
    }
    static func getTomorrowTimeByMonth()->String{
        
        
        let date = NSDate.dateTomorrow()
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "MM-dd"
        return timeFormatter.string(from: date as! Date) as String
        
        
    }
//    static func CalculateDays(fromday:String,toDays:String)->Int{
//        let data = NSDate.st
//        
//        return 1
//    }
    
    
}
