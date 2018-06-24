import UIKit
import FirebaseFirestore

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var presenter: UserInfoPresenterInterface!
    let userInfoItems:[String] = ["メールアドレス", "姓", "名", "ログアウト"]
//    let userInfo:[String]
    @IBOutlet weak var userInfoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ユーザー情報"
//        var userInfo = presenter.getUserInfo()
        
//        let db = Firestore.firestore()
//        let settings = db.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        db.settings = settings
//
//        db.collection("clients").whereField("email", isEqualTo: "yusukechief@gmail.com").limit(to: 1).getDocuments { (snapshot, error) in
//            if error != nil{
//                print("error")
//            } else {
//                for document in (snapshot?.documents)! {
//                    if let password = document.data()["password"] as? String {
//                        print(password)
//                    }
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath)
        cell.textLabel!.text = sidemenu_items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.getSideMenuPage(indexPath.row)
    }

}

extension UserInfoViewController: UserInfoViewInterface {
    
}
