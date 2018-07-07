import UIKit
import Eureka

class UserInfoViewController: FormViewController {
    var presenter: UserInfoPresenterInterface!
    var userInfoValues:[String:String] = [:]
    let userInfoLabels:[String:String] = ["email":"Email", "last_name":"姓", "first_name":"名"]
    let userInfoItems:[String] = ["email", "last_name", "first_name"]
    
    @IBOutlet weak var userInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ユーザー情報"
        userInfoValues = presenter.getUserInfo()
    
        form
            +++ Section("ユーザー情報")
    
            <<< TextRow(){ row in
                row.title = userInfoLabels["last_name"]
                row.value = userInfoValues["last_name"]
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
                        self.presenter.updateUserInfo(item: "last_name", input: row.value!)
                    }
            }
            
            <<< TextRow(){ row in
                row.title = userInfoLabels["first_name"]
                row.value = userInfoValues["first_name"]
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
                        self.presenter.updateUserInfo(item: "first_name", input: row.value!)
                    }
            }
            
            <<< LabelRow(){ row in
                row.title = userInfoLabels["email"]
                row.value = userInfoValues["email"]
                }.cellSetup { cell, row in
                    cell.textLabel?.textColor = UIColor.black
                    cell.detailTextLabel?.textColor = UIColor.black
                }.onCellSelection { cell, row in
                    
    //                if(!watcher.admin!){
    //                    self.showAlert(name: watcher.last_name!+" "+watcher.first_name!, access_auth_id: watcher.access_auth_id!, row: row)
    //                }
    //                self.presenter.updateUserEmail(email: row.value!, password: String)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UserInfoViewController: UserInfoViewInterface {
    func showAlert(message: String){
        let alert = UIAlertController( title: "問題が発生しました",
                                       message: message,
                                       preferredStyle: UIAlertControllerStyle.alert )
        let cancelAction:UIAlertAction = UIAlertAction( title: "キャンセル",
                                                        style: UIAlertActionStyle.cancel,
                                                        handler:nil )
        let saveAction:UIAlertAction = UIAlertAction( title: "OK",
                                                      style: UIAlertActionStyle.default,
                                                      handler:nil )
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
}
