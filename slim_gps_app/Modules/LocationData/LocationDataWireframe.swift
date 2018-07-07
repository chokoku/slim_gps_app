import UIKit
import SlideMenuControllerSwift

class LocationDataWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule( serial_num: String ) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LocationData") as! LocationDataViewController
        viewController.serial_num = serial_num
        let interactor = LocationDataInteractor()
        let presenter = LocationDataPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension LocationDataWireframe: LocationDataWireframeInterface {
//    func pushDeviceSettingPage(_ serial_num:String){
//        print("move to \(serial_num) setting page")
//        let nextVC = DeviceSettingWireframe().configureModule(serial_num)
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
//        (sideMenuController.mainViewController as! UINavigationController).pushViewController(nextVC, animated: true)
//        sideMenuController.closeLeft()
    
//    func popBackToMainPage(){
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let sideMenuController: SlideMenuController = appDelegate.window!.rootViewController as! SlideMenuController
//        let navigationController = sideMenuController.mainViewController as! UINavigationController
//        navigationController.popToViewController(navigationController.viewControllers[0], animated: true)
//    }
}
