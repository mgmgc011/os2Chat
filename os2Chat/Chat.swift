//
//  Chat.swift
//  os2Chat
//
//  Created by Mingu Chu on 5/1/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit
import SwiftyJSON


struct Chat {
    var id: NSNumber?
    var name: String?
    var users: [User] = []
    var last_chat_message : Message?
    
    init(json: JSON) {
        id = json["id"].number
        name = json["name"].string
        
        let usersJSON = json["users"]
        for (_, value) in usersJSON {
            let user = User(json: value)
            users.append(user)
        }
        
        last_chat_message = Message(json: json["last_chat_message"])
        
    }
    
    
    
}
