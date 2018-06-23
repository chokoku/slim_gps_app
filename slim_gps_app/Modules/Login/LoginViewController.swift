//import UIKit
//
//final class LoginViewController: UIViewController, UITextFieldDelegate {
//    
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var messageLabel: UILabel!
//    @IBOutlet weak var loginButton: UIButton!
//    
//    var presenter: LoginPresenterInterface!
//    
//    // MARK: - Lifecycle -
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        _setupUI()
//    }
//    
//    @IBAction func loginButtonTapped(_ sender: Any) {
//        presenter.loginButtonTapped(id: emailTextField.text ?? "", password: passwordTextField.text ?? "")
//    }
//}
//
//// MARK: - Extensions -
//
//extension LoginViewController {
//    private func _setupUI() {
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//    }
//}
//extension LoginViewController: LoginViewInterface {
//}
//
////extension LoginViewController: StoryboardLoadable {
////    static var storyboardName: String {
////        return Storyboard.LoginViewController.name
////    }
////}
