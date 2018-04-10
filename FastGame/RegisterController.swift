//
//  RegisterController.swift
//  FastGame
//
//  Created by Supakornbabe on 4/9/2561 BE.
//  Copyright © 2561 Supakornbabe. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class RegisterController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var idCardTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBAction func registerButton(_ sender: Any) {
        let api = "http://35.198.203.166/api/register.php"
        
        let requestURL = NSURL(string: api)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        //request.addValue("application/json",forHTTPHeaderField:"content-type")
        //request.addValue("application/json",forHTTPHeaderField:"Accept")
        
        let phone = phoneTextField.text
        let email = emailTextField.text
        let idCard = idCardTextField.text
        let lastname = lastnameTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        let firstName = firstNameTextField.text
        let passwordAgain = passwordAgainTextField.text
        
        let postParameters = "phoneNo="+phone!+"&email="+email!+"&idCardNo="+idCard!+"&lastName="+lastname!+"&username="+username!+"&password="+password!+"&firstName="+firstName!;
        
        if( (phone?.isEmpty)! || (email?.isEmpty)! || (idCard?.isEmpty)! || (lastname?.isEmpty)!||(username?.isEmpty)! || (password?.isEmpty)! || (firstName?.isEmpty)! || (passwordAgain?.isEmpty)! ){
            displayAlertwithOKButton(head:"All Field are REQUIRED")
            return
        }
        
        if (passwordAgain != password){
            displayAlertwithOKButton(head:"Password Not Match")
            return
        }
        
     
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
        displayAlertwithOKButton(head:"Register Success")
        
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Tap Outside Keyboard To Dissmiss
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    func displayAlertwithOKButton(head:String , message:String = ""){
        let alertController = UIAlertController(title: head, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}
