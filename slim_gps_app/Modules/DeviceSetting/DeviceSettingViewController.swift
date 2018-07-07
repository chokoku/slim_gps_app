import UIKit
import Eureka

//import SlideMenuControllerSwift
//import FontAwesome_swift

class DeviceSettingViewController: FormViewController {
    
    var presenter: DeviceSettingPresenterInterface!
    var accessAuth = [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]()
    
    @IBOutlet weak var deviceInfoTable: UITableView!
    
    // set values from DeviceSettingWireframe
    var serial_num: String!
    var mode: String!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "デバイス設定"
        
        accessAuth = presenter.getAccessAuth(device_id: serial_num) // [(access_auth_id: String?, first_name: String?, last_name: String?, admin: Bool?)]
        
        form +++ Section("一般")
            <<< TextRow(){ row in
                row.baseCell.isUserInteractionEnabled = false
                row.title = "シリアル番号"
                row.value = serial_num
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
                        let result = self.presenter.changeDeviceName(device_id: self.serial_num, name: row.value! )
                        if( !result ){ self.failureAlert(message: "デバイス名の保存に失敗しました") }
                    }
            }
            
            <<< ActionSheetRow<String>("mode") { row in
                row.title = "モード"
                row.selectorTitle = "モードを選択してください"
                row.options = ["見守りモード(省電力)", "見守りモード(通常)", "紛失対策モード"]
                row.value = "見守りモード(省電力)"    // initially selected
                }.cellSetup { cell, row in
                    cell.detailTextLabel?.textColor = UIColor.black
                }.onChange { row in
                    let modeLabels:[String:String] = ["見守りモード(省電力)":"watching_powerSaving", "見守りモード(通常)":"watching_normal", "紛失対策モード":"lost_proof"]
                    self.presenter.changeDeviceSetting( device_id: self.serial_num, mode: modeLabels[row.value!]! )
            }
        
        
        let accessAuthSection = Section("アクセス権")
        form +++ accessAuthSection
        for watcher in accessAuth {
            accessAuthSection <<< LabelRow(){ row in
                row.title = watcher.admin! ? "管理者" : "×"
                row.value = watcher.last_name!+" "+watcher.first_name!
                }.cellSetup { cell, row in
                    cell.textLabel?.textColor = watcher.admin! ? UIColor.black : UIColor.lightGray
                    cell.detailTextLabel?.textColor = UIColor.black
                }.onCellSelection { cell, row in
                    if(!watcher.admin!){
                        self.showAlert(name: watcher.last_name!+" "+watcher.first_name!, access_auth_id: watcher.access_auth_id!, row: row)
                    }
            }
        }
    }
    
    func showAlert(name: String, access_auth_id: String, row: BaseRow){
        let alert = UIAlertController( title: "アクセス権の削除", message: "\(name)さんを削除しますか？", preferredStyle: UIAlertControllerStyle.alert )
        let cancelAction:UIAlertAction = UIAlertAction( title: "キャンセル", style: UIAlertActionStyle.cancel, handler:nil )
        let saveAction:UIAlertAction = UIAlertAction( title: "削除", style: UIAlertActionStyle.default,handler:{ (action) in
            self.presenter.removeAccessAuth(access_auth_id: access_auth_id)
            row.hidden = true
            row.evaluateHidden()
        })
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    func failureAlert(message: String){
        let alert = UIAlertController( title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert )
        let OKAction:UIAlertAction = UIAlertAction( title: "OK", style: UIAlertActionStyle.default,handler: nil)
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DeviceSettingViewController: DeviceSettingViewInterface {
    
}
