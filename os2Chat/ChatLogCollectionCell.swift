//
//  ChatListCell.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/11/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class ChatLogCollectionCell: UICollectionViewCell {
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Example"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let timeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.oraColor()
        label.text = "time example"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewWidthAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(bubbleView)
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -30).isActive = true
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8)
        bubbleViewWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 250)
        bubbleViewWidthAnchor?.isActive = true
        
        addSubview(textView)
        textView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20).isActive = true
        textView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor, constant: -8).isActive = true
        
        addSubview(timeNameLabel)
        timeNameLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        timeNameLabel.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 16).isActive = true
        timeNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timeNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}












