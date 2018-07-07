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
    func getMainPage(){
        
//        let sideMenuController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuViewController
//        let presenter = SideMenuPresenter(wireframe: self, view: sideMenuController)
//        sideMenuController.presenter = presenter
//        return sideMenuController
//
//        if let storyboard = self.storyboard {
//            let vc = storyboard.instantiateViewControllerWithIdentifier("firstNavigationController") as! UINavigationController
//            self.presentViewController(vc, animated: false, completion: nil)
//        }
//
        
        let mainWireframe = MainWireframe()
        let navigationController = mainWireframe.configureModule()
        let sideMenuWireframe = SideMenuWireframe()
        let leftVC = sideMenuWireframe.configureModule()
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftVC)
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        appDelegate.window!.rootViewController!.present(slideMenuController, animated: true)
    }

}
