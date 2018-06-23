import UIKit

class MainWireframe {
    func configureModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController  = storyboard.instantiateViewController(withIdentifier: "Main")
//        let viewController = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.output = presenter
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

extension MainWireframe: MainWireframeInterface {
}
