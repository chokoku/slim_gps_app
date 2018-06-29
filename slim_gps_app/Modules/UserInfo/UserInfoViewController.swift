import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var presenter: UserInfoPresenterInterface!
    var userInfo:[String:String] = [:]
    let userInfoLabels:[String:String] = ["email":"メールアドレス", "last_name":"姓", "first_name":"名"]
    let userInfoItems:[String] = ["email", "last_name", "first_name"]
    @IBOutlet weak var userInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ユーザー情報"
        userInfo = presenter.getUserInfo()
        print("userInfo:\(userInfo)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoItems.count+1 // 1 means logout
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        if ( indexPath.row == 3 ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleLabel", for: indexPath)
            cell.textLabel!.text = "ログアウト"
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath) as! UserInfoViewCell
            cell.setCell(titleText: userInfoLabels[userInfoItems[indexPath.row]]!, userInfoText: userInfoItems[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        presenter.getSideMenuPage(indexPath.row)
    }

}

extension UserInfoViewController: UserInfoViewInterface {
    
}
