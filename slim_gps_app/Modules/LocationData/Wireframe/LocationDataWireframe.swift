import UIKit
import SlideMenuControllerSwift

class LocationDataWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( deviceID: String, latestLatitude: Double, latestLongitude: Double ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationData") as! LocationDataViewController
        
        viewController.deviceID = deviceID
        viewController.latestLatitude = latestLatitude
        viewController.latestLongitude = latestLongitude
        
        let interactor = LocationDataInteractor()
        let presenter = LocationDataPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LocationDataWireframe: LocationDataWireframeInterface {
}
