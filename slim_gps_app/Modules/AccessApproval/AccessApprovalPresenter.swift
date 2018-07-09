import Foundation
import FirebaseAuth

final class AccessApprovalPresenter {

    private weak var _view: AccessApprovalViewInterface?
    private var _wireframe: AccessApprovalWireframeInterface
    private var _interactor: AccessApprovalInteractorInterface
    
    init(wireframe: AccessApprovalWireframeInterface, view: AccessApprovalViewInterface, interactor: AccessApprovalInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension AccessApprovalPresenter: AccessApprovalPresenterInterface {
    func getRequesters() -> [(access_auth_id: String, first_name: String?, last_name: String?)]{
        let user = Auth.auth().currentUser
        return _interactor.fetchRequesters(uid: user!.uid)
    }
}
