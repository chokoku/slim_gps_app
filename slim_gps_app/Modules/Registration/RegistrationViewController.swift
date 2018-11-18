import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SlideMenuControllerSwift

final class RegistraionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    
    @IBAction func createAccountAction(_ sender: Any) {
        if emailTextField.text == "" {
            self.showAlert(message: "Emailとパスワードを入力してください")
        } else if firstNameText.text == "" || lastNameText.text == ""  {
            self.showAlert(message: "姓名を入力してください")
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    // Disable button
                    self.registrationButton.isEnabled = false
                    
                    // Start the indicator
                    self.view.addSubview(self.indicator)
                    self.view.bringSubviewToFront(self.indicator)
                    self.indicator.startAnimating()
                    
                    // Initiate DB
                    let db = Firestore.firestore()
                    let settings = db.settings
                    settings.areTimestampsInSnapshotsEnabled = true
                    db.settings = settings
                    
                    // Create a client document
                    let uid = Auth.auth().currentUser!.uid
                    db.collection("clients").document(uid).setData([ "lastName": self.lastNameText.text!, "firstName": self.firstNameText.text!, "type": "individual" ]) { err in
                        
                        self.registrationButton.isEnabled = true
                        self.indicator.stopAnimating() // Stop the indicator
                        
                        if let _ = err {
                            self.showAlert(message: "ユーザーの作成に失敗しました")
                        } else {
                            let mainWireframe = MainWireframe()
                            let navigationController = mainWireframe.configureModule()
                            let sideMenuWireframe = SideMenuWireframe()
                            let leftVC = sideMenuWireframe.configureModule()
                            let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftVC)
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window?.rootViewController = slideMenuController
                        }
                    }
                } else {
                    let alertController = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
