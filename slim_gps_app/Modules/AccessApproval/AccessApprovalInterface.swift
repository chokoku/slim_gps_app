import UIKit

protocol AccessApprovalViewInterface: class {
}

protocol AccessApprovalWireframeInterface: class {
}

protocol AccessApprovalPresenterInterface: class {
    func getRequesters() -> [(access_auth_id: String, first_name: String?, last_name: String?)]
}

protocol AccessApprovalInteractorInterface: class {
    func fetchRequesters(uid:String) -> [(access_auth_id: String, first_name: String?, last_name: String?)]
}
