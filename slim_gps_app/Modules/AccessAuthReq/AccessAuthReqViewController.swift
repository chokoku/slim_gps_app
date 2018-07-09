import UIKit

class AccessAuthReqViewController: UIViewController, UITextFieldDelegate  {

    var presenter: AccessAuthReqPresenterInterface!
    var popup:UIView!

    @IBOutlet weak var serialNumInput: UITextField!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "アクセスリクエスト"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitSerialNum(_ sender: Any) {
        if self.serialNumInput.text == "" {
            let alertController = UIAlertController(title: "エラー", message: "シリアル番号を入力してください", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let indicator = UIActivityIndicatorView()
            indicator.activityIndicatorViewStyle = .whiteLarge
            indicator.center = self.view.center
            indicator.color = UIColor.black
            self.view.addSubview(indicator)
            self.view.bringSubview(toFront: indicator)
            indicator.startAnimating()

            presenter.submitSerialNum(serialNum: self.serialNumInput.text!){ (err: String?) in
                indicator.stopAnimating()
                if let err = err {
                    self.showAlert(message: err)
                } else {
                    print("error2:\(err)")
                    self.serialNumInput.text = ""
                    self.message.text = "申請しました"
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissPopUp(){
        if popup != nil { // Dismiss the view from here
            popup.removeFromSuperview()
        }
    }
}

extension AccessAuthReqViewController: AccessAuthReqViewInterface {
    
}
