import UIKit
import Eureka
import PopupDialog

class UserInfoViewController: FormViewController {
    var presenter: UserInfoPresenterInterface!
    var userInfoValues:[String:String] = [:]
    let userInfoLabels:[String:String] = ["email":"Email", "lastName":"姓", "firstName":"名"]
    let userInfoItems:[String] = ["email", "lastName", "firstName"]
    let indicator = UIActivityIndicatorView()
    let cellHeight:CGFloat = 60.0

    @IBOutlet weak var userInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ユーザー情報"
        presenter.getUserInfo()
        
        // Initiate indicator
        indicator.style = .whiteLarge
        indicator.center = self.view.center
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUserInfoForm(userInfo: [String:String]){
        self.userInfoValues = userInfo
        form
            +++ Section("ユーザー情報")
            
            // Set lastName textField
            <<< TextRow(){ // $0 = row
                $0.title = userInfoLabels["lastName"]
                $0.value = userInfoValues["lastName"]
                $0.add(rule: RuleRequired(msg: "\(userInfoLabels["lastName"]!)を入力してください"))
                $0.validationOptions = .validatesOnChange // when the input is empty, !row.isValid
                }.cellSetup { cell, row in
                    cell.titleLabel?.textColor = .black
                }.cellUpdate { cell, row in
                    cell.height = {self.cellHeight}
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                    cell.textField.font = UIFont.systemFont(ofSize: 20.0)
                    if row.value == self.userInfoLabels["lastName"] {
                        // ignore
                    } else if !row.isValid {
                        cell.titleLabel?.textColor = .red
                        var errors = ""
                        for error in row.validationErrors {
                            let errorString = error.msg + "\n"
                            errors = errors + errorString
                        }
                        cell.detailTextLabel?.text = errors
                        cell.detailTextLabel?.isHidden = false
                        cell.detailTextLabel?.textAlignment = .left
                    } else {
                        self.userInfoValues["lastName"] = row.value!
                        self.presenter.updateUserInfo(key: "lastName", value: row.value!)
                    }
            }
            
            // Set firstName textField
            <<< TextRow(){
                $0.title = userInfoLabels["firstName"]
                $0.value = userInfoValues["firstName"]!
                $0.add(rule: RuleRequired(msg: "\(userInfoLabels["firstName"]!)を入力してください"))
                }.cellSetup { cell, row in
                    cell.titleLabel?.textColor = .black
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                }.cellUpdate { cell, row in
                    cell.height = {self.cellHeight}
                    cell.textField.font = UIFont.systemFont(ofSize: 20.0)
                    if row.value == self.userInfoLabels["firstName"] {
                        // ignore
                    } else if !row.isValid {
                        cell.titleLabel?.textColor = .red
                        var errors = ""
                        for error in row.validationErrors {
                            let errorString = error.msg + "\n"
                            errors = errors + errorString
                        }
                        cell.detailTextLabel?.text = errors
                        cell.detailTextLabel?.isHidden = false
                        cell.detailTextLabel?.textAlignment = .left
                    } else {
                        self.userInfoValues["firstName"] = row.value!
                        self.presenter.updateUserInfo(key: "firstName", value: row.value!)
                    }
            }
            
            // Set email textField
            <<< LabelRow(){ row in
                row.title = userInfoLabels["email"]
                row.value = userInfoValues["email"]
                row.tag = "email"
                }.cellSetup { cell, row in
                    cell.height = {self.cellHeight}
                    cell.textLabel?.textColor = UIColor.black
                    cell.detailTextLabel?.textColor = UIColor.black
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                }.onCellSelection { cell, row in
                    let vc = EmailUpdateModalViewController(nibName: "EmailUpdateModalViewController", bundle: nil)
                    vc.email = row.value
                    let popup = PopupDialog(viewController: vc)
                    let btnOK = DefaultButton(title: "保存") {
//                        var name = vc.spotName.text
//                        if (name!.isEmpty){ name = "名無しスポット" }
//                        self.presenter.addNotifSpot(name: name!, latitude: coordinate.latitude, longitude: coordinate.longitude, radius: 100.0)
                        
                        let email = vc.emailField.text ?? ""
                        let pass = vc.passwordField.text ?? ""
                        let passConf = vc.passwordConfField.text ?? ""
                        if email.isEmpty || pass.isEmpty || passConf.isEmpty{
                            self.showAlert(message: "Emailかパスワードが入力されていません")
                        } else {
                            if(pass != passConf){
                                self.showAlert(message: "パスワードが一致しません")
                            } else {
                                for row in self.form.rows {
                                    row.baseCell.isUserInteractionEnabled = false
                                }
                                self.indicator.startAnimating()
                                self.presenter.updateUserEmail(email: email, password: pass)
                            }
                        }
                    }
                    popup.addButton(btnOK)
                    let btnCancel = CancelButton(title: "キャンセル") { }
                    popup.addButton(btnCancel)
                    popup.buttonAlignment = .horizontal
                    self.present(popup, animated: true, completion: nil)
            }
            
            // Set logout button
            +++ Section("その他")
            <<< ButtonRow(){ row in
                row.title = "ログアウト"
                }.cellSetup { cell, row in
                    cell.height = {self.cellHeight}
                    cell.tintColor = UIColor.lightGray
                }.onCellSelection { cell, row in
                    self.presenter.logout()
        }
    }
    
}

extension UserInfoViewController: UserInfoViewInterface {
    func showAlert(message: String){
        indicator.stopAnimating()
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertController.Style.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertAction.Style.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    func logOutForError(message: String){
        self.presenter.logout()
//        showAlert(message: message)
    }
    
    func emailIsUpdated(email: String){
        for row in form.rows {
            row.baseCell.isUserInteractionEnabled = true
        }
        indicator.stopAnimating()
        userInfoValues["email"] = email
        (form.rowBy(tag: "email") as! LabelRow).value = email
        self.form.rowBy(tag: "email")?.reload()
    }
}
