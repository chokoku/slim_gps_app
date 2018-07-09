import Foundation
import FirebaseAuth

final class AccessAuthReqPresenter {
    
    private weak var _view: AccessAuthReqViewInterface?
    private var _wireframe: AccessAuthReqWireframeInterface
    private var _interactor: AccessAuthReqInteractorInterface
    
    init(wireframe: AccessAuthReqWireframeInterface, view: AccessAuthReqViewInterface, interactor: AccessAuthReqInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

extension AccessAuthReqPresenter: AccessAuthReqPresenterInterface {
    func submitSerialNum(serialNum: String, completion: @escaping (String?) -> Void ){
        var error: String?
        let user = Auth.auth().currentUser
        
        _interactor.updateAccessAuth(serialNum: serialNum, uid: user!.uid) { (err: String?) in
            if let err = err {
                error = err
            }
            completion(error)
        }
    }
}
