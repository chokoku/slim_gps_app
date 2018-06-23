//import UIKit
//
//
//final class LoginWireframe: LoginWireframeInterface {
//    
//    // MARK: - Private properties -
//    
//    // MARK: - Module setup -
//    func configureModule() -> UIViewController {
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
//        let interactor = LoginInteractor()
//        let presenter = LoginPresenter(wireframe: self, view: viewController, interactor: interactor)
//        viewController.presenter = presenter
//        interactor.output = presenter
//        
//        let navigationController = UINavigationController(rootViewController: viewController)
//        
//        return navigationController
//    }
//    
//    // MARK: - Transitions -
//    
//    func showMainScreen() {
//        let root = AppDelegate.shared.rootViewCotnroller
//        root.showMainScreen()
//    }
//}
