//
//  addButtonView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/14/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class AddButtonView: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.tintColor = .oraColor()

        self.setImage(UIImage(named:"addButton"), for: .normal)
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.fill
        
        self.layer.cornerRadius = 25
        
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    

    
}
