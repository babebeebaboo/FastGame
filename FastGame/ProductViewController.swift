//
//  ProductViewController.swift
//  FastGame
//
//  Created by Supakornbabe on 4/11/2561 BE.
//  Copyright © 2561 Supakornbabe. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ProductViewController: UIViewController {
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let retrievedUsernameString: String? = KeychainWrapper.standard.string(forKey: "username")
        
        let retrievedPasswordString: String? = KeychainWrapper.standard.string(forKey: "password")
        
        userLabel.text = "UserID: " + retrievedUsernameString!
        
        passwordLabel.text = "Password: " + retrievedPasswordString!
    }

    
    @IBAction func signoutTapped(_ sender: Any) {
        let removeUsernameSuccessful: Bool = KeychainWrapper.standard.remove(key: "username")
        let removePasswordSuccessful: Bool = KeychainWrapper.standard.remove(key: "password")
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
