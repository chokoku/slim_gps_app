import UIKit

final class ContactUsWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ContactUs") as! ContactUsViewController
        let interactor = ContactUsInteractor()
        let presenter = ContactUsPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

extension ContactUsWireframe: ContactUsWireframeInterface {

}
