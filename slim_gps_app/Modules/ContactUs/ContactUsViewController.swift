import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SCLAlertView

class ContactUsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var contactUsTextView: UITextView!
    let db = Firestore.firestore()
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let user = Auth.auth().currentUser
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        db.collection("contactUsForms").addDocument(data: [ "clientID": user!.uid, "message": contactUsTextView.text, "OS":"iOS\(systemVersion)", "device":"\(model)" ]) { error in
            if let error = error {
                CommonFunc.addErrorReport(category: "ContactUs-01", description: error.localizedDescription)
                self.showAlert(message:"メッセージの保存に失敗しました")
            } else {
                self.contactUsTextView.text = nil
                self.view.endEditing(true)
                SCLAlertView().showSuccess("送信しました", subTitle:"")
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "お問い合わせ"
        
        contactUsTextView.delegate = self

        // Configure textView
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        contactUsTextView.layer.borderWidth = 0.5
        contactUsTextView.layer.borderColor = borderColor.cgColor
        contactUsTextView.layer.cornerRadius = 10.0
        
        // Initialize firebase firestore
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        // Set editing done button
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil) // スペーサー
        let commitButton : UIBarButtonItem = UIBarButtonItem(title: "完了", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.commitButtonTapped))// 閉じるボタン
        kbToolBar.items = [spacer, commitButton]
        contactUsTextView.inputAccessoryView = kbToolBar
    }
    
    // テキストビューにフォーカスが移った
//    func textViewDidBeginEditing() -> Bool {
//        return true
//    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertController.Style.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertAction.Style.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func commitButtonTapped (){
//        contactUsTextView.resignFirstResponder()
        self.view.endEditing(true)
    }


}
