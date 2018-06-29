import UIKit
import FirebaseAuth

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var presenter: SideMenuPresenterInterface!
    @IBOutlet weak var sideMenuTable: UITableView!
    let sidemenuList:[String:String] = ["Login":"ログイン", "Registration":"登録", "UserInfo":"ユーザー情報", "NotifSpot":"通知スポットの設定", "AccessAuthReq":"見守りリクエスト", "ContactUs":"お問い合わせ", "TermOfUse":"利用規約"]
    let sidemenuItems:[String] =  ["Login", "Registration", "UserInfo", "NotifSpot", "AccessAuthReq", "ContactUs", "TermOfUse"]

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTable.dataSource = self
        sideMenuTable.delegate = self
        if let _ = Auth.auth().currentUser {
            print("user is logged in")
        } else{
            print("user is logged out")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidemenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath)
        cell.textLabel!.text = sidemenuList[sidemenuItems[indexPath.row]]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let _ = Auth.auth().currentUser {
            presenter.getSideMenuPage(sidemenuItems[indexPath.row])
        } else if ["Login","Registration","TermOfUse"].contains(sidemenuItems[indexPath.row]) {
            presenter.getSideMenuPage(sidemenuItems[indexPath.row])
        } else {
            let alertController = UIAlertController(title: "Error", message: "ログイン後にアクセスできます　", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension SideMenuViewController: SideMenuViewInterface {
    
}
