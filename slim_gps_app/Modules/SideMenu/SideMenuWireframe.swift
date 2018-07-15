import UIKit
import SlideMenuControllerSwift

final class SideMenuWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func configureModule() -> UIViewController {
        let sideMenuController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuViewController
        let presenter = SideMenuPresenter(wireframe: self, view: sideMenuController)
        sideMenuController.presenter = presenter
        return sideMenuController
    }
}

extension SideMenuWireframe: SideMenuWireframeInterface {
    func pushSideMenuPage(index: String) {
        var nextVC: UIViewController?

        print("move to \(index) page")
        
        switch index {
        case "Login":
            nextVC = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        case "Registration":
            nextVC = storyboard.instantiateViewController(withIdentifier: "Registration") as! RegistraionViewController
        case "UserInfo":
            nextVC = UserInfoWireframe().configureModule()
        case "NotifSpot":
            nextVC = NotifSpotWireframe().configureModule()
        case "AccessAuthReq":
            nextVC = AccessAuthReqWireframe().configureModule()
        case "AccessApproval":
            nextVC = AccessApprovalWireframe().configureModule()
        case "ContactUs":
            nextVC = storyboard.instantiateViewController(withIdentifier: "ContactUs") as! ContactUsViewController
        case "TermOfUse":
            nextVC = storyboard.instantiateViewController(withIdentifier: "TermOfUse") as! TermOfUseViewController
        default:
            print("no wireframe setting")
        }
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC!, animated: true)
        sideMenuController.closeLeft()
    }
}
