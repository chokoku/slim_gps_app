import UIKit
import SlideMenuControllerSwift

class LatestLocationWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LatestLocation") as! LatestLocationViewController
        viewController.deviceID = deviceID
        let interactor = LatestLocationInteractor()
        let presenter = LatestLocationPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LatestLocationWireframe: LatestLocationWireframeInterface {
}
