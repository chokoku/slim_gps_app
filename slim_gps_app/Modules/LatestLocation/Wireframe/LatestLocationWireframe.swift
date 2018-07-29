import UIKit
import SlideMenuControllerSwift

class LatestLocationWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String, latestLatitude: Double, latestLongitude: Double ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LatestLocation") as! LatestLocationViewController
        
        viewController.deviceID = deviceID
        viewController.latestLatitude = latestLatitude
        viewController.latestLongitude = latestLongitude
        
        let interactor = LatestLocationInteractor()
        let presenter = LatestLocationPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LatestLocationWireframe: LatestLocationWireframeInterface {
}
