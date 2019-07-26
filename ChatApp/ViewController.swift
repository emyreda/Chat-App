//
//  ViewController.swift
//  ChatApp
//
//  Created by Mac on 7/18/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    @IBOutlet weak var tableListOfChat: UITableView!
    @IBOutlet weak var txtChat: UITextField!
  //  @IBOutlet weak var imageAttach: UIImageView!
    var img:ChatCell?
    
   
    var imageReference: StorageReference{
        
        
        return Storage.storage().reference().child("images")
        
    }
    
    
    var ref = DatabaseReference()
    var userName:String?
    var listOfChat = [ChatObj]()
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        loginAnonymously()
    }
    
    
    
    func LoadChatRoom(){
        
        self.ref.child("chat").queryOrdered(byChild: "Date").observe(.value, with:{ (snapshot) in
            
            
               self.listOfChat.removeAll()
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                
                
                for snap in snapshot{
                    
                    if let postData = snap.value as? [String:AnyObject]{
                        
                        
                        
                        let userName = postData["name"] as? String
                        
                        let text = postData["text"] as? String
                        let imgPath = postData["ImgPath"] as? String
                        
                        var postDate:CLong?
                        
                        if let postDateIn = postData["Date"] as? CLong{
                            
                            postDate = postDateIn
                            
                        }
                        
                        
                        self.listOfChat.append(ChatObj(name: userName!, text: text!, Date: "\(String(describing: postDate))"))
                        
                        
                        
                    }
                }
                
                
                self.tableListOfChat.reloadData()
                
               
                
            }
            
            
            
        })
        
    }
    
    
    
    
    func loginAnonymously(){
        
        
        Auth.auth().signInAnonymously(){
            
            (user,error) in
            
            if let error = error{
                
                print("error\(error)")
                
            }else{
                
                
                print("user\(String(describing:user?.user))")
                self.LoadChatRoom()
                
            }
            
            
        }
        
    }
    
    
    @IBAction func sendToRoom(_ sender: Any) {
        
        
        AddSnap(ImgPath: "No_Image")
        
    }
    
    func AddSnap(ImgPath:String){
        
        
        let dic = ["text":txtChat.text as AnyObject
            
            ,"name":userName as AnyObject
            ,"Date":ServerValue.timestamp()
            ,"ImgPath":ImgPath
            
            
            ] as [String:Any]
        
        // we use id to create new node not only update the old node
        ref.child("chat").childByAutoId().setValue(dic)
        
        txtChat.text = ""
        
        

        
    }
    
    
    

    
    
}//End of viewController
    
extension ViewController:UITableViewDataSource , UITableViewDelegate{
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChat.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        
          cell.setChat(chat:listOfChat[indexPath.row])
          cell.showText.layer.cornerRadius = 10
       
        
            return cell
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    
}


