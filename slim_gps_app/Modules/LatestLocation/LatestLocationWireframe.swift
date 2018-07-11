import UIKit
import SlideMenuControllerSwift

class LatestLocationWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( serialNum: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LatestLocation") as! LatestLocationViewController
        viewController.serialNum = serialNum
        let interactor = LatestLocationInteractor()
        let presenter = LatestLocationPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LatestLocationWireframe: LatestLocationWireframeInterface {
    func popBackToMainPage(){
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
        let navigationController = sideMenuController.mainViewController as! UINavigationController
        navigationController.popToViewController(navigationController.viewControllers[0], animated: true)
    }
}
