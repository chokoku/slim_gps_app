import UIKit

class AccessAuthReqViewController: UIViewController, UITextFieldDelegate  {

    var presenter: AccessAuthReqPresenterInterface!
    let indicator = UIActivityIndicatorView()

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var serialNumInput: UITextField!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serialNumInput.delegate = self
        self.navigationItem.title = "アクセスリクエスト"
        
        // Configure an indicator
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = self.view.center
        indicator.color = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitSerialNum(_ sender: Any) {
        
        // Start the indicator
        self.view.addSubview(indicator)
        self.view.bringSubview(toFront: indicator)
        indicator.startAnimating()
        
        // Disable the requestButton
        submitButton.isEnabled = false
        
        if self.serialNumInput.text == "" {
            showAlert(message: "シリアル番号を入力してください")
        } else {
            presenter.submitSerialNum(serialNum: self.serialNumInput.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

}

extension AccessAuthReqViewController: AccessAuthReqViewInterface {
    
    func accessAuthReqIsSubmitted(){
        submitButton.isEnabled = true
        indicator.stopAnimating()
        self.serialNumInput.text = ""
        self.message.text = "申請しました"
    }
    
    func showAlert(message: String){
        
        // Stop the indicator
        indicator.stopAnimating()
        
        // Enable the requestButton
        submitButton.isEnabled = true

        // Show an alert
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}
