//
//  ChatListTableView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/12/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class ChatListTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    let headerId = "headerId"
    

    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.register(ChatListCell.self, forCellReuseIdentifier: cellId)
        self.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)
        self.separatorColor = .clear
        self.delegate = self
        self.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatListCell
        cell.textLabel?.text = "From Bella"
        cell.detailTextLabel?.text = "Time ago"
        cell.messageLabel.text = "Yo YO yo yO"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        header?.textLabel?.text = "Today"
        
        
        
        return header
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    
    
    
    
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}





