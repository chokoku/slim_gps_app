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
    func pushSideMenuPage(_ index: String) {
        var nextVC: UIViewController?

        print("move to \(index) page")
        switch index {
        case "Login":
            nextVC = storyboard.instantiateViewController(withIdentifier: "Login")
        case "Registration":
            nextVC = storyboard.instantiateViewController(withIdentifier: "Registration")
        case "UserInfo":
            nextVC = UserInfoWireframe().configureModule()
        case "NotifSpot":
            nextVC = NotifSpotWireframe().configureModule()
        case "AccessAuthReq":
            nextVC = AccessAuthReqWireframe().configureModule()
        case "ContactUs":
            nextVC = ContactUsWireframe().configureModule()
        case "TermOfUse":
            nextVC = storyboard.instantiateViewController(withIdentifier: "TermOfUse")
        default:
            print("no wireframe setting")
        }
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC!, animated: true)
        sideMenuController.closeLeft()
    }
}
