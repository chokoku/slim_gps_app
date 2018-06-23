import UIKit
import SlideMenuControllerSwift

class MainViewController: UIViewController {

    var presenter: MainPresenterInterface!

    @objc private func didTapLeftMenuIcon() {
        self.slideMenuController()?.openLeft()
    }
    
    @objc private func didTapRightMenuIcon() {
        self.slideMenuController()?.openRight()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButtonWithImage(UIImage(named: "menu_icon")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MainViewController: MainViewInterface {
    
}
