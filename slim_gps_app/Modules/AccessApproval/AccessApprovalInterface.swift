import UIKit

protocol AccessApprovalViewInterface: class {
    func addRequesters(access_auth_id:String, first_name:String?, last_name:String?)
    func showAlert(message:String)
}

protocol AccessApprovalWireframeInterface: class {
}

protocol AccessApprovalPresenterInterface: class {
    func getRequesters()
    func addRequesters(access_auth_id:String, first_name:String?, last_name:String?)
    func pushAlert(message:String)
    func approveAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void)
    func rejectAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void)
}

protocol AccessApprovalInteractorInterface: class {
    func fetchRequesters(uid:String)
    func approveAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void)
    func rejectAccessRequest(access_auth_id: String, completion: @escaping (String?) -> Void)
}
