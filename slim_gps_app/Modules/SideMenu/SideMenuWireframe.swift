import UIKit

final class SideMenuWireframe {
    func configureModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
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
                nextVC = UserInfoViewController()
            case 1:
                nextVC = NotifSpotViewController()
            case 2:
                nextVC = AccessAuthReqViewController()
            case 3:
                nextVC = ContactUsViewController()
            case 4:
                nextVC = TermOfUseViewController()
            default:
                nextVC = UserInfoViewController()
            }
//        let navigationController = UINavigationController()
//        let SlideMenuController = UIApplication.shared.keyWindow?.rootViewController
//       let nvc = SlideMenuController.mainViewController as! UINavigationController
//        SlideMenuController.pushViewController(nextVC, animated: true)
          //navigationController.pushViewController(nextVC, animated: true)
//        self.slideMenuController()?.closeLeft()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
