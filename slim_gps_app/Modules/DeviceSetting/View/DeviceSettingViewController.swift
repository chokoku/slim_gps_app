import UIKit
import Eureka

class DeviceSettingViewController: FormViewController {
    
    var presenter: DeviceSettingPresenterInterface!
    var accessAuth = [(clientID: String?, firstName: String?, lastName: String?, admin: Bool?)]()
    let modeLabels:[String:String] = ["見守りモード(省電力)":"watching_powerSaving", "見守りモード(通常)":"watching_normal", "紛失対策モード":"lost_proof"]

    @IBOutlet weak var deviceInfoTable: UITableView!
    
    // Set values from DeviceSettingWireframe
    var serialNum: String!
    var mode: String!
    var name: String!
    
    let cellHeight:CGFloat = 60.0
    let defFontSize:CGFloat = 18.0
    let indicator = UIActivityIndicatorView()
    
    // accessAuthSection in form
    let accessAuthSection = Section("アクセス権")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "デバイス設定"
        
        // Initiate indicator
        indicator.style = .whiteLarge
        indicator.center = self.view.center
        indicator.color = UIColor.black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        
        form +++ Section("一般")
            <<< TextRow(){ row in
                row.baseCell.isUserInteractionEnabled = false
                row.title = "シリアル番号"
                row.value = serialNum
                }.cellUpdate { cell, row in
                    cell.height = {self.cellHeight}
                    cell.textLabel?.font = UIFont.systemFont(ofSize:  self.defFontSize)
                    cell.textField.font = UIFont.systemFont(ofSize:  self.defFontSize)
                    cell.textField.textColor = .lightGray
            }
            
            <<< TextRow(){ row in
                row.title = "名前"
                row.value = name
                row.add(rule: RuleRequired(msg: "名前を入力してください"))
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    cell.height = {self.cellHeight}
                    cell.textLabel?.font = UIFont.systemFont(ofSize:  self.defFontSize)
                    cell.textField.font = UIFont.systemFont(ofSize:  self.defFontSize)
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
                }.cellSetup { cell, row in // original color is gray
                    cell.detailTextLabel?.textColor = UIColor.black
                }.cellUpdate { cell, row in
                    cell.height = {self.cellHeight}
                    cell.textLabel?.font = UIFont.systemFont(ofSize:  self.defFontSize)
                    cell.detailTextLabel!.font = UIFont.systemFont(ofSize: self.defFontSize)
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
    
    func showAccessAuthDeleteAlert(name: String, clientID: String, row: BaseRow){
        let alert = UIAlertController( title: "アクセス権の削除", message: "\(name)さんを削除しますか？", preferredStyle: UIAlertController.Style.alert )
        let cancelAction:UIAlertAction = UIAlertAction( title: "キャンセル", style: UIAlertAction.Style.cancel, handler:nil )
        let saveAction:UIAlertAction = UIAlertAction( title: "削除", style: UIAlertAction.Style.default, handler:{ (action) in
            self.indicator.startAnimating()
            self.presenter.deleteAccessAuth(deviceID: self.serialNum, clientID: clientID)
        })
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }

}

extension DeviceSettingViewController: DeviceSettingViewInterface {
    
    func accessAuthIsGotten(watcher:(clientID: String, firstName: String, lastName: String, admin: Bool)){
        accessAuthSection <<< LabelRow(){ row in
            row.title = watcher.admin ? "管理者" : "×"
            row.value = watcher.lastName+" "+watcher.firstName
            row.tag = watcher.clientID
            }.cellSetup { cell, row in
                cell.height = {self.cellHeight}
                cell.detailTextLabel?.textColor = UIColor.black
            }.cellUpdate { cell, row in
                cell.textLabel?.textColor = watcher.admin ? UIColor.black : UIColor.lightGray
            }.onCellSelection { cell, row in
                if(!watcher.admin){
                    self.showAccessAuthDeleteAlert(name: watcher.lastName+" "+watcher.firstName, clientID: watcher.clientID, row: row)
                }
        }
    }
    
    func showAlert(message: String){
        indicator.stopAnimating()
        let alert = UIAlertController( title: " エラー", message: message, preferredStyle: UIAlertController.Style.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertAction.Style.cancel, handler:nil )
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    func accessAuthIsDeleted(clientID: String){
        let row = form.rowBy(tag :clientID)!
        row.hidden = true
        row.evaluateHidden()
        indicator.stopAnimating()
    }
}
