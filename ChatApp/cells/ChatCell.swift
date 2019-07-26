//
//  ChatCell.swift
//  ChatApp
//
//  Created by Mac on 7/18/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    
    @IBOutlet weak var showUserName: UILabel!
    @IBOutlet weak var showText: UITextView!
    
    func setChat(chat:ChatObj){
        
        
        showUserName.text = chat.name
        showText.text = chat.text
        
        
        
    }
    
    
    
    
    
}
