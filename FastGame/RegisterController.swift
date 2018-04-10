//
//  RegisterController.swift
//  FastGame
//
//  Created by Supakornbabe on 4/9/2561 BE.
//  Copyright © 2561 Supakornbabe. All rights reserved.
//

import UIKit

class RegisterController: UIViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var idCardTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        let api = "http://35.198.203.166/register/test.php"
        
        let requestURL = NSURL(string: api)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        
        let phone = phoneTextField.text
        let email = emailTextField.text
        let idCard = idCardTextField.text
        let lastname = lastnameTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        let firstName = firstNameTextField.text
        
        let postParameters = "phoneNo="+phone!+"&email="+email!+"&idCardNo="+idCard!+"&lastName="+lastname!+"&username="+username!+"&password="+password!+"&firstName="+firstName!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Tap Outside Keyboard To Dissmiss
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
    }
}
