import UIKit

class UserInfoViewController: UIViewController {
    
    var presenter: UserInfoPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ユーザー情報"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UserInfoViewController: UserInfoViewInterface {
    
}
