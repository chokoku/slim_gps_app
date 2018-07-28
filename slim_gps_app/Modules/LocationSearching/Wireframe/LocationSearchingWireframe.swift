import UIKit
import SlideMenuControllerSwift

class LocationSearchingWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationSearching") as! LocationSearchingViewController
        viewController.deviceID = deviceID
        let interactor = LocationSearchingInteractor()
        let presenter = LocationSearchingPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LocationSearchingWireframe: LocationSearchingWireframeInterface {
}
