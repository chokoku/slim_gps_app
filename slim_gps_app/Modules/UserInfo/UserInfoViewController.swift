import UIKit
import Eureka

class UserInfoViewController: FormViewController {
    var presenter: UserInfoPresenterInterface!
    var userInfoValues:[String:String?] = [:]
    let userInfoLabels:[String:String] = ["email":"Email", "last_name":"姓", "first_name":"名"]
    let userInfoItems:[String] = ["email", "last_name", "first_name"]
    
    @IBOutlet weak var userInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ユーザー情報"
        presenter.getUserInfo(){ (userInfo:[String:String?], err: String?) in
            if let err = err {
                self.showAlert(message: err)
            } else {
//                 e.g)[( serial_num: Optional("dfasdfaeadaerq"),
//                        admin:      Optional(true),
//                        mode:       Optional("watching_normal"),
//                        name:       Optional("Drrrrrrddddd"),
//                        latitude:   Optional(35.637363999999998),
//                        longitude:  Optional(139.69534200000001),
//                        battery:    Optional(67) )]
                self.userInfoValues = userInfo
                self.setUserInfoForm()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUserInfoForm(){
        form
            +++ Section("ユーザー情報")
            
            <<< TextRow(){ row in
                row.title = userInfoLabels["last_name"]
                row.value = userInfoValues["last_name"] ?? ""
                row.add(rule: RuleRequired(msg: "\(userInfoLabels["last_name"]!)を入力してください"))
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
                        self.presenter.updateUserInfo(item: "last_name", input: row.value!){ (err: String?) in
                            print("err result:\(err)")
                            if let err = err {
                                self.showAlert(message: err)
                            }
                        }
                    }
            }
            
            <<< TextRow(){ row in
                row.title = userInfoLabels["first_name"]
                row.value = userInfoValues["first_name"]!
                row.add(rule: RuleRequired(msg: "\(userInfoLabels["first_name"]!)を入力してください"))
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
                        self.presenter.updateUserInfo(item: "first_name", input: row.value!){ (err: String?) in
                            print("err result:\(err)")
                            if let err = err {
                                self.showAlert(message: err)
                            }
                        }
                    }
            }
            
            <<< LabelRow(){ row in
                row.title = userInfoLabels["email"]
                row.value = userInfoValues["email"] ?? ""
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
                                self.presenter.updateUserEmail(email: email, password: pass){ (err: String?) in
                                    print("err result:\(err)")
                                    if let err = err {
                                        self.showAlert(message: err)
                                    } else {
                                        self.userInfoValues["email"] = email
                                    }
                                }
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
            
            +++ Section("その他")
            <<< ButtonRow(){ row in
                row.title = "ログアウト"
                }.cellSetup { cell, row in
                    cell.tintColor = UIColor.lightGray
                }.onCellSelection { cell, row in
                    self.presenter.logout()
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UserInfoViewController: UserInfoViewInterface {
}
