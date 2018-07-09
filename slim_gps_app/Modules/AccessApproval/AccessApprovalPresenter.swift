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
    func getRequesters() {
        let user = Auth.auth().currentUser
        _interactor.fetchRequesters(uid: user!.uid)
    }
    
    func addRequesters(access_auth_id: String, first_name: String?, last_name: String?){
        _view!.addRequesters(access_auth_id: access_auth_id, first_name: first_name, last_name: last_name)
    }
    
    func pushAlert(message:String){
        _view!.showAlert(message:message)
    }

    func approveAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void){
        var error: String?
        _interactor.approveAccessRequest(access_auth_id: access_auth_id){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
    
    func rejectAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void){
        var error: String?
        _interactor.rejectAccessRequest(access_auth_id: access_auth_id){ (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }

}
