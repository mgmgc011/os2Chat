//
//  ChatListTableView.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/12/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit


class ChatListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var chatListController: ChatListController? {
        didSet {
//            tableView(self, didSelectRowAt: self.indexPathForSelectedRow!)
//            print(self.indexPathForSelectedRow!)
        }
    }

    
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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








