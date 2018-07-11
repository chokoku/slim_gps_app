import UIKit
import SlideMenuControllerSwift

final class UserInfoWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserInfo") as! UserInfoViewController
        let interactor = UserInfoInteractor()
        let presenter = UserInfoPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension UserInfoWireframe: UserInfoWireframeInterface {
    func logout(){

        // Configure slideMenuController
        let mainWireframe = MainWireframe()
        let navigationController = mainWireframe.configureModule()
        let sideMenuWireframe = SideMenuWireframe()
        let leftVC = sideMenuWireframe.configureModule()
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftVC)
        
        // Present slideMenuController View
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController!.present(slideMenuController, animated: true)
    }

}
