import UIKit
import SwiftKeychainWrapper
class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBAction func loginTapped(_ sender: Any) {
        let saveUsernameSuccessful: Bool = KeychainWrapper.standard.set((usernameTextField.text)!, forKey: "username")
        let savePasswordSuccessful: Bool = KeychainWrapper.standard.set((passwordTextField.text)!, forKey: "password")
        if(saveUsernameSuccessful && savePasswordSuccessful){
            print("saved user password")
        }else{
            print("can't save user password")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let retrievedUsernameString: String? = KeychainWrapper.standard.string(forKey: "username")
        
        let retrievedPasswordString: String? = KeychainWrapper.standard.string(forKey: "password")
        if(retrievedUsernameString != nil && retrievedPasswordString != nil){
            let ProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            self.present(ProductViewController, animated: false)
        }
    }
}

