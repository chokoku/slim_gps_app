import UIKit
import SlideMenuControllerSwift

final class SideMenuWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuViewController
        let presenter = SideMenuPresenter(wireframe: self, view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}

extension SideMenuWireframe: SideMenuWireframeInterface {
    func pushSideMenuPage(_ index: Int) {
        let nextVC: UIViewController
            switch index {
            case 0:
                nextVC = storyboard.instantiateViewController(withIdentifier: "UserInfo")
            case 1:
                nextVC = storyboard.instantiateViewController(withIdentifier: "NotifSpot")
            case 2:
                nextVC = storyboard.instantiateViewController(withIdentifier: "AccessAuthReq")
            case 3:
                nextVC = storyboard.instantiateViewController(withIdentifier: "ContactUs")
            case 4:
                nextVC = storyboard.instantiateViewController(withIdentifier: "TermOfUse")
            default:
                nextVC = storyboard.instantiateViewController(withIdentifier: "UserInfo")
            }
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
        sideMenuController.closeLeft()
    }
}
