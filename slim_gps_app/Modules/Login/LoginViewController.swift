import UIKit
import Firebase
import FirebaseAuth
import SlideMenuControllerSwift

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Configure an indicator
        indicator.style = .whiteLarge
        indicator.center = self.view.center
        indicator.color = UIColor.black
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {

        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "エラー", message: "Eメールとパスワードを入力してください", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            // Disable button
            self.loginButton.isEnabled = false
            
            // Start the indicator
            self.view.addSubview(self.indicator)
            self.view.bringSubviewToFront(self.indicator)
            self.indicator.startAnimating()
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    let mainWireframe = MainWireframe()
                    let navigationController = mainWireframe.configureModule()
                    let sideMenuWireframe = SideMenuWireframe()
                    let leftVC = sideMenuWireframe.configureModule()
                    let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftVC)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = slideMenuController
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                self.loginButton.isEnabled = true
                self.indicator.stopAnimating() // Stop the indicator
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}

