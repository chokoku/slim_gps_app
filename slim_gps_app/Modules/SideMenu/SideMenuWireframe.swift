import UIKit

final class SideMenuWireframe {

}

extension SideMenuWireframe: SideMenuWireframeInterface {
    func pushSideMenuPage(_ index: Int!) {
        let nextVC: UIViewController
            switch index {
            case 1:
                nextVC = UserInfoViewController()
            case 2:
                nextVC = NotifSpotViewController()
            case 3:
                nextVC = AccessAuthReqViewController()
            case 4:
                nextVC = ContactUsViewController()
            case 5:
                nextVC = TermOfUseViewController()
            default:
                nextVC = UserInfoViewController()
            }
        
        let navigationController = UINavigationController()
        navigationController.pushViewController(nextVC, animated: true)
    }
}
