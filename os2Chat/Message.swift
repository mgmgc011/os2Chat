//
//  Message.swift
//  os2Chat
//
//  Created by Mingu Chu on 5/1/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Message {
    
    var id: NSNumber?
    var chat_id: NSNumber?
    var user_id: NSNumber?
    var message: String?
    var created_at: String?
    var user: User?
    
    init(json: JSON) {
        id = json["id"].number
        chat_id = json["chat_id"].number
        user_id = json["user_id"].number
        message = json["message"].string
        created_at = json["created_at"].string?.convertSinceNow()
        
        
        
        user = User(json: json["user"])
        
        
        
    }
    
    
}
