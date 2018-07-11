import UIKit

protocol AccessAuthReqPresenterInterface: class {
    func submitSerialNum(serialNum: String, completion: @escaping (String?) -> Void )
}

protocol AccessAuthReqViewInterface: class {
}

protocol AccessAuthReqInteractorInterface: class {
    func updateAccessAuth(serialNum: String, uid: String, completion: @escaping (String?) -> Void )
}

protocol AccessAuthReqWireframeInterface: class {
}
