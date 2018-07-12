import UIKit
import Eureka

class DeviceSettingViewController: FormViewController {
    
    var presenter: DeviceSettingPresenterInterface!
    var accessAuth = [(accessAuthID: String?, firstName: String?, lastName: String?, admin: Bool?)]()
    let modeLabels:[String:String] = ["見守りモード(省電力)":"watching_powerSaving", "見守りモード(通常)":"watching_normal", "紛失対策モード":"lost_proof"]

    @IBOutlet weak var deviceInfoTable: UITableView!
    
    // Set values from DeviceSettingWireframe
    var serialNum: String!
    var mode: String!
    var name: String!
    
    // accessAuthSection in form
    let accessAuthSection = Section("アクセス権")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "デバイス設定"
        
        form +++ Section("一般")
            <<< TextRow(){ row in
                row.baseCell.isUserInteractionEnabled = false
                row.title = "シリアル番号"
                row.value = serialNum
                }.cellSetup { cell, row in
                    cell.titleLabel?.textColor = .black
            }
            
            <<< TextRow(){ row in
                row.title = "名前"
                row.value = name
                row.add(rule: RuleRequired(msg: "名前を入力してください"))
                row.validationOptions = .validatesOnChangeAfterBlurred
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
                        self.presenter.updateDeviceName( deviceID: self.serialNum, name: row.value! )
                    }
            }
            
            <<< ActionSheetRow<String>("mode") { row in
                row.title = "モード"
                row.selectorTitle = "モードを選択してください"
                row.options = ["見守りモード(省電力)", "見守りモード(通常)", "紛失対策モード"]
                row.value = modeLabels.filter{$0.value == mode}.keys.first
                }.cellSetup { cell, row in
                    cell.detailTextLabel?.textColor = UIColor.black
                }.onChange { row in
                    self.mode = self.modeLabels[row.value!]!
                    self.presenter.updateDeviceSetting( deviceID: self.serialNum, mode: self.modeLabels[row.value!]! )
            }
        
        form +++ accessAuthSection
        presenter.getAccessAuth(deviceID: serialNum)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAccessAuthDeleteAlert(name: String, accessAuthID: String, row: BaseRow){
        let alert = UIAlertController( title: "アクセス権の削除", message: "\(name)さんを削除しますか？", preferredStyle: UIAlertControllerStyle.alert )
        let cancelAction:UIAlertAction = UIAlertAction( title: "キャンセル", style: UIAlertActionStyle.cancel, handler:nil )
        let saveAction:UIAlertAction = UIAlertAction( title: "削除", style: UIAlertActionStyle.default, handler:{ (action) in
            self.presenter.deleteAccessAuth(accessAuthID: accessAuthID)
        })
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }

}

extension DeviceSettingViewController: DeviceSettingViewInterface {
    
    func accessAuthIsGotten(watcher:(accessAuthID: String, firstName: String, lastName: String, admin: Bool)){
        accessAuthSection <<< LabelRow(){ row in
            row.title = watcher.admin ? "管理者" : "×"
            row.value = watcher.lastName+" "+watcher.firstName
            row.tag = watcher.accessAuthID
            }.cellSetup { cell, row in
                cell.textLabel?.textColor = watcher.admin ? UIColor.black : UIColor.lightGray
                cell.detailTextLabel?.textColor = UIColor.black
            }.onCellSelection { cell, row in
                if(!watcher.admin){
                    self.showAccessAuthDeleteAlert(name: watcher.lastName+" "+watcher.firstName, accessAuthID: watcher.accessAuthID, row: row)
                }
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    func accessAuthIsDeleted(accessAuthID: String){
        let row = form.rowBy(tag :accessAuthID)!
        row.hidden = true
        row.evaluateHidden()
    }
}
