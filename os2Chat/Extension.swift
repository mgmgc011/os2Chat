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

extension Int {
    
    func converToString() -> String {
        
        let secPerMin = 60
        let secPerHour = 3600
        let secPerDay = 86400
        let secPerWeek = 604800
        let secPerMonth = 2419200
        let secPerYear = 31536000
        
        if self < secPerMin {
            print("just now")
            return "just now"
            
        } else if self < secPerHour {
            print("\(self/secPerMin) mins ago")
            return "\(self/secPerMin) mins ago"
            
        } else if self < secPerDay {
            print("\(self/secPerHour) hours ago")
            return "\(self/secPerHour) hours ago"
            
        } else if self < secPerWeek {
            print("\(self/secPerDay) days ago")
            return "\(self/secPerDay) days ago"
            
        } else if self < secPerMonth {
            print("\(self/secPerWeek) weeks ago")
            return "\(self/secPerWeek) weeks ago"
            
        } else if self < secPerYear {
            print("\(self/secPerMonth) months ago")
            return "\(self/secPerMonth) months ago"
            
        } else {
            print("\(self/secPerYear) years ago")
            return "\(self/secPerYear) years ago"
        }
    }
    
}

extension String {

    func convertToSeconds() -> Int {
        
        let formmater = ISO8601DateFormatter().date(from: self)
        let interval = Int(formmater!.timeIntervalSinceNow) * -1
        
        print(interval)
        return interval
    }
}


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

