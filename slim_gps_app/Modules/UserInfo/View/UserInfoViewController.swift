import UIKit
import Eureka

class UserInfoViewController: FormViewController {
    var presenter: UserInfoPresenterInterface!
    var userInfoValues:[String:String] = [:]
    let userInfoLabels:[String:String] = ["email":"Email", "lastName":"姓", "firstName":"名"]
    let userInfoItems:[String] = ["email", "lastName", "firstName"]
    let indicator = UIActivityIndicatorView()
    
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
            <<< TextRow(){ row in
                row.title = userInfoLabels["lastName"]
                row.value = userInfoValues["lastName"]
                row.add(rule: RuleRequired(msg: "\(userInfoLabels["lastName"]!)を入力してください"))
                }.cellSetup { cell, row in
                    cell.titleLabel?.textColor = .black
                }.cellUpdate { cell, row in
                    if !row.isValid {
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
            <<< TextRow(){ row in
                row.title = userInfoLabels["firstName"]
                row.value = userInfoValues["firstName"]!
                row.add(rule: RuleRequired(msg: "\(userInfoLabels["firstName"]!)を入力してください"))
                }.cellSetup { cell, row in
                    cell.titleLabel?.textColor = .black
                }.cellUpdate { cell, row in
                    if !row.isValid {
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
                    cell.textLabel?.textColor = UIColor.black
                    cell.detailTextLabel?.textColor = UIColor.black
                }.onCellSelection { cell, row in
                    let alert = UIAlertController(title: "Emailの更新", message: "", preferredStyle: .alert)
                    let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
                        (action:UIAlertAction!) -> Void in
                        // password and password confirmation are not empty
                        let email = alert.textFields![0].text ?? ""
                        let pass = alert.textFields![1].text ?? ""
                        let pass_con = alert.textFields![2].text ?? ""
                        if email.isEmpty || pass.isEmpty || pass_con.isEmpty{
                            self.showAlert(message: "Emailかパスワードが入力されていません")
                        } else {
                            if(pass != pass_con){
                                self.showAlert(message: "パスワードが一致しません")
                            } else {
                                for row in self.form.rows {
                                    row.baseCell.isUserInteractionEnabled = false
                                }
                                self.indicator.startAnimating()
                                self.presenter.updateUserEmail(email: email, password: pass)
                            }
                        }
                    })
                    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
                    alert.addAction(saveAction)
                    alert.addAction(cancelAction)
                    alert.addTextField(configurationHandler: { (textField) in
                        textField.text = row.value
                        textField.placeholder = "Emailを入力してください"
                    })
                    alert.addTextField(configurationHandler: { (textField) in
                        textField.placeholder = "パスワード"
                    })
                    alert.addTextField(configurationHandler: { (textField) in
                        textField.placeholder = "パスワードの確認"
                    })
                    self.present(alert, animated: true, completion: nil)
            }
            
            // Set logout button
            +++ Section("その他")
            <<< ButtonRow(){ row in
                row.title = "ログアウト"
                }.cellSetup { cell, row in
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
