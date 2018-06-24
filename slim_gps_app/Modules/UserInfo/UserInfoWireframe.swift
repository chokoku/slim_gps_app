import UIKit

final class UserInfoWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserInfo") as! UserInfoViewController
        let interactor = UserInfoInteractor()
        let presenter = UserInfoPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.output = presenter
        return viewController
    }
}

extension UserInfoWireframe: UserInfoWireframeInterface {
//    func pushSideMenuPage(_ index: Int) {
//        let nextVC: UIViewController
//        switch index {
//        case 0:
//            nextVC = storyboard.instantiateViewController(withIdentifier: "UserInfo")
//        case 1:
//            nextVC = storyboard.instantiateViewController(withIdentifier: "NotifSpot")
//        case 2:
//            nextVC = storyboard.instantiateViewController(withIdentifier: "AccessAuthReq")
//        case 3:
//            nextVC = storyboard.instantiateViewController(withIdentifier: "ContactUs")
//        case 4:
//            nextVC = storyboard.instantiateViewController(withIdentifier: "TermOfUse")
//        default:
//            nextVC = storyboard.instantiateViewController(withIdentifier: "UserInfo")
//        }
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
//        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
//        sideMenuController.closeLeft()
//    }
}
