import UIKit

protocol AccessAuthReqPresenterInterface: class {
    
    // To View
    func accessAuthReqIsSubmitted()
    func showAlert(message: String)
    
    //To Interactor
    func submitSerialNum(serialNum: String )
}

protocol AccessAuthReqViewInterface: class {
    func accessAuthReqIsSubmitted()
    func showAlert(message: String)
}

protocol AccessAuthReqInteractorInterface: class {
    func createAccessAuthReq(serialNum: String, uid: String)
}

protocol AccessAuthReqWireframeInterface: class {
}
