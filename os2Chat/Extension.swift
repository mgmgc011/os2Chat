//
//  UIColor.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/10/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
    
    class func oraColor() -> UIColor {
        return UIColor(r: 247, g: 167, b: 0)
    }

}

extension String {
    
    func convertSinceNow() -> String {

        let secPerMin = 60
        let secPerHour = 3600
        let secPerDay = 86400
        let secPerWeek = 604800
        let secPerMonth = 2419200
        let secPerYear = 31536000
        
        let formmater = ISO8601DateFormatter().date(from: self)
        let interval = Int(formmater!.timeIntervalSinceNow) * -1
        
        if interval < secPerMin {
            print("just now")
            return "just now"
            
        } else if interval < secPerHour {
            print("\(interval/secPerMin) mins ago")
            return "\(interval/secPerMin) mins ago"
            
        } else if interval < secPerDay {
            print("\(interval/secPerHour) hours ago")
            return "\(interval/secPerHour) hours ago"
            
        } else if interval < secPerWeek {
            print("\(interval/secPerDay) days ago")
            return "\(interval/secPerDay) days ago"
            
        } else if interval < secPerMonth {
            print("\(interval/secPerWeek) weeks ago")
            return "\(interval/secPerWeek) weeks ago"
            
        } else if interval < secPerYear {
            print("\(interval/secPerMonth) months ago")
            return "\(interval/secPerMonth) months ago"
            
        } else {
            print("\(interval/secPerYear) years ago")
            return "\(interval/secPerYear) years ago"
        }
    }
}


