//
//  VCLogin.swift
//  ChatApp
//
//  Created by Mac on 7/18/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {
    
        
        @IBOutlet weak var username: UITextField!
        @IBOutlet weak var Login: UIButton!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        
        Login.layer.cornerRadius = 15
        
        }
        
        
        
    
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "seg"{
                if let dis = segue.destination as? ViewController {
                    
                    
                    dis.userName = username.text
                    
                }
                
            }
        }
        
    
        
}
