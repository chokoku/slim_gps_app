import UIKit

class AccessAuthReqViewController: UIViewController {

    var presenter: AccessAuthReqPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "見守りリクエスト"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension AccessAuthReqViewController: AccessAuthReqViewInterface {
    
}
