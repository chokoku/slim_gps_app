import UIKit

class ContactUsViewController: UIViewController {

    var presenter: ContactUsPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "お問い合わせ"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ContactUsViewController: ContactUsViewInterface {
    
}
