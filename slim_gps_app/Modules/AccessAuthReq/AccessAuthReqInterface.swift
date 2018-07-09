import UIKit

protocol AccessAuthReqViewInterface: class {
}

protocol AccessAuthReqWireframeInterface: class {
}

protocol AccessAuthReqPresenterInterface: class {
    func submitSerialNum(serialNum: String, completion: @escaping (String?) -> Void )
}

protocol AccessAuthReqInteractorInterface: class {
    func updateAccessAuth(serialNum: String, uid: String, completion: @escaping (String?) -> Void )
}
