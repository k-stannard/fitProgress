/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 
 Template from: https://github.com/thierryH91200/Charts-log/blob/master/Charts-log/Demos/DateValueFormatter.swift
 ****************************************/

import Foundation
import Charts

open class DateValueFormatter : NSObject, IAxisValueFormatter
{
    var dateFormatter : DateFormatter
    var miniTime :Double
    
    public init(miniTime: Double) {
        //super.init()
        self.miniTime = miniTime
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd/MM"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone?
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        let date2 = Date(timeIntervalSince1970 : (value * 3600 * 24) + miniTime)
        return dateFormatter.string(from: date2)
    }
}
