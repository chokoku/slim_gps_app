import UIKit

final class AccessAuthReqWireframe {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func configureModule() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "AccessAuthReq") as! AccessAuthReqViewController
        let interactor = AccessAuthReqInteractor()
        let presenter = AccessAuthReqPresenter(wireframe: self, view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }}

extension AccessAuthReqWireframe: AccessAuthReqWireframeInterface {
    
}
