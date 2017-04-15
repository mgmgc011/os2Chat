//
//  ChatListCell.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/11/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class ChatListCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        detailTextLabel?.textColor = UIColor.oraColor()
        
        
        
        addSubview(messageLabel)
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: detailTextLabel!.bottomAnchor, constant: 0).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: textLabel!.widthAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor).isActive = true
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 20, y: textLabel!.frame.origin.y - 14, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 24, y: detailTextLabel!.frame.origin.y - 12, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)

        
    }
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}






class SearchBarView: UISearchBar {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}












