import UIKit

class NotifSpotViewController: UIViewController {

    var presenter: NotifSpotPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "通知領域の設定"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension NotifSpotViewController: NotifSpotViewInterface {
    
}
